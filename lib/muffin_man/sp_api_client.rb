require "aws-sigv4"
require "uri"
require "aws-sdk-core"
require "typhoeus"
require "securerandom"
require "muffin_man/muffin_logger"

module MuffinMan
  class SpApiClient
    attr_reader :refresh_token, :client_id, :client_secret, :aws_access_key_id,
                :aws_secret_access_key, :sts_iam_role_arn, :sandbox, :config,
                :region, :request_type, :local_var_path, :query_params,
                :request_body, :scope, :access_token_cache_key, :credentials,
                :pii_data_elements

    ACCESS_TOKEN_URL = "https://api.amazon.com/auth/o2/token".freeze
    SERVICE_NAME = "execute-api".freeze
    AWS_REGION_MAP = {
      "na" => "us-east-1",
      "eu" => "eu-west-1",
      "fe" => "us-west-2"
    }.freeze

    UNPROCESSABLE_ENTITY_STATUS_CODE = 422

    def initialize(credentials, sandbox = false)
      @refresh_token = credentials[:refresh_token]
      @client_id = credentials[:client_id]
      @client_secret = credentials[:client_secret]
      @aws_access_key_id = credentials[:aws_access_key_id]
      @aws_secret_access_key = credentials[:aws_secret_access_key]
      @sts_iam_role_arn = credentials[:sts_iam_role_arn]
      @region = credentials[:region] || "na"
      @scope = credentials[:scope]
      @access_token_cache_key = credentials[:access_token_cache_key]
      @sandbox = sandbox
      @credentials = credentials
      @pii_data_elements = []
      Typhoeus::Config.user_agent = ""
      @config = MuffinMan.configuration
    end

    private

    def call_api
      res = Typhoeus.send(request_type.downcase.to_sym, request.url, request_opts)
      if self.class.const_defined?('LOGGING_ENABLED')
        level = res.code == 200 ? :info : :error
        log_request_and_response(level, res)
      end
      res
    rescue SpApiAuthError => e
      e.auth_response
    end

    def request_opts
      opts = { headers: headers }
      opts[:body] = request_body.to_json if request_body
      opts
    end

    def sp_api_host
      hostname = "sellingpartnerapi-#{region}.amazon.com"
      sandbox ? hostname.prepend("sandbox.") : hostname
    end

    def sp_api_url
      "https://#{sp_api_host}"
    end

    def canonical_uri
      # local_var_path is defined in subclasses
      "#{sp_api_url}#{local_var_path}"
    end

    def request
      Typhoeus::Request.new(canonical_uri, params: query_params)
    end

    def retrieve_lwa_access_token
      return request_lwa_access_token["access_token"] unless use_cache?

      stored_token = config.get_access_token.call(access_token_cache_key)
      if stored_token.nil?
        new_token = request_lwa_access_token
        config.save_access_token.call(access_token_cache_key, new_token)
        new_token["access_token"]
      else
        stored_token
      end
    end

    def use_cache?
      defined?(config.save_access_token) && defined?(config.get_access_token) && access_token_cache_key
    end

    def request_lwa_access_token
      body = {
        grant_type: "refresh_token",
        refresh_token: refresh_token,
        client_id: client_id,
        client_secret: client_secret
      }
      response = Typhoeus.post(
        ACCESS_TOKEN_URL,
        body: URI.encode_www_form(body),
        headers: {
          "Content-Type" => "application/x-www-form-urlencoded;charset=UTF-8"
        }
      )
      raise SpApiAuthError, response if response.failure?

      JSON.parse(response.body)
    end

    def retrieve_grantless_access_token
      # No storage of this type for now
      request_grantless_access_token["access_token"]
    end

    def request_grantless_access_token
      body = {
        grant_type: "client_credentials",
        scope: scope,
        client_id: client_id,
        client_secret: client_secret
      }
      response = Typhoeus.post(
        ACCESS_TOKEN_URL,
        body: URI.encode_www_form(body),
        headers: {
          "Content-Type" => "application/x-www-form-urlencoded;charset=UTF-8"
        }
      )
      JSON.parse(response.body)
    end

    def request_sts_token
      client = Aws::STS::Client.new(
        region: derive_aws_region,
        credentials: Aws::Credentials.new(aws_access_key_id, aws_secret_access_key),
        http_wire_trace: (ENV.fetch("AWS_DEBUG", nil) == "true" || false)
      )
      client.assume_role(role_arn: sts_iam_role_arn, role_session_name: SecureRandom.uuid)
    end

    def signed_request
      request_config = {
        service: SERVICE_NAME,
        region: derive_aws_region,
        endpoint: sp_api_host
      }
      if sts_iam_role_arn.nil?
        request_config[:access_key_id] = aws_access_key_id
        request_config[:secret_access_key] = aws_secret_access_key
      else
        request_config[:credentials_provider] = request_sts_token
      end
      signer = Aws::Sigv4::Signer.new(request_config)
      signer.sign_request(http_method: request_type, url: request.url, body: request_body&.to_json)
    end

    def headers
      if requires_rdt_token_for_pii?
        access_token = retrieve_rdt_access_token || retrieve_lwa_access_token
      else
        access_token = scope ? retrieve_grantless_access_token : retrieve_lwa_access_token
      end
      headers = {
        "x-amz-access-token" => access_token,
        "user-agent" => "MuffinMan/#{VERSION} (Language=Ruby)",
        "content-type" => "application/json"
      }
      signed_request.headers.merge(headers)
    end

    def requires_rdt_token_for_pii?
      pii_data_elements.any?
    end

    def retrieve_rdt_access_token
      rdt_token_response = Tokens::V20210301.new(credentials, sandbox).create_restricted_data_token(
        @local_var_path, @request_type, pii_data_elements
      )
      JSON.parse(rdt_token_response.body)["restrictedDataToken"]
    end

    def derive_aws_region
      @aws_region ||= AWS_REGION_MAP[region]
      unless @aws_region
        raise MuffinMan::Error,
              "#{region} is not supported or does not exist. Region must be one of the following: #{AWS_REGION_MAP.keys.join(", ")}"
      end

      @aws_region
    end

    def unprocessable_entity(errors)
      Typhoeus::Response.new(code: UNPROCESSABLE_ENTITY_STATUS_CODE, body: { errors: errors.to_s }.to_json)
    end

    def sp_api_params(params)
      params.to_h.transform_keys { |key| key.to_s.split("_").map.with_index { |x, i| i.positive? ? x.capitalize : x }.join }
    end

    def log_request_and_response(level, res)
      log_info = "REQUEST\n
        canonical_uri:#{canonical_uri}\n\n
        query_params:#{query_params}\n\n
        RESPONSE\n
        response_headers=#{res.headers}\n\n
        response_body=#{res.body}\n\n
      "
      MuffinLogger.logger.send(level, log_info)
    end
  end
end
