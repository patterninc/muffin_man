require 'aws-sigv4'
require 'uri'
require 'aws-sdk-core'
require 'typhoeus'
require 'securerandom'

module MuffinMan
  class SpApiClient
    attr_reader :refresh_token, :client_id, :client_secret, :aws_access_key_id,
      :aws_secret_access_key, :sts_iam_role_arn, :sandbox, :config, :region, :request_type,
      :local_var_path, :query_params, :request_body, :scope
    ACCESS_TOKEN_URL = 'https://api.amazon.com/auth/o2/token'.freeze
    SERVICE_NAME = 'execute-api'.freeze
    AWS_REGION_MAP = {
      'na' => 'us-east-1',
      'eu' => 'eu-west-1',
      'fe' => 'us-west-2'
    }.freeze

    def initialize(credentials, sandbox = false)
      @refresh_token = credentials[:refresh_token]
      @client_id = credentials[:client_id]
      @client_secret = credentials[:client_secret]
      @aws_access_key_id = credentials[:aws_access_key_id]
      @aws_secret_access_key = credentials[:aws_secret_access_key]
      @sts_iam_role_arn = credentials[:sts_iam_role_arn]
      @region = credentials[:region] || 'na'
      @scope = credentials[:scope]
      @sandbox = sandbox
      Typhoeus::Config.user_agent = ''
      @config = MuffinMan.configuration
    end

    private

    def call_api
      Typhoeus.send(request_type.downcase.to_sym, request.url, request_opts)
    end

    def request_opts
      opts = { headers: headers }
      if request_body
        opts[:body] = request_body.to_json
      end
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
      return request_lwa_access_token['access_token'] unless defined?(config.get_access_token)
      stored_token = config.get_access_token.call(client_id)
      if stored_token.nil?
        new_token = request_lwa_access_token
        config.save_access_token.call(client_id, new_token) if defined?(config.save_access_token)
        return new_token['access_token']
      else
        return stored_token
      end
    end

    def request_lwa_access_token
      body = {
        grant_type: 'refresh_token',
        refresh_token: refresh_token,
        client_id: client_id,
        client_secret: client_secret
      }
      response = Typhoeus.post(
        ACCESS_TOKEN_URL,
        body: URI.encode_www_form(body),
        headers: {
          'Content-Type' => 'application/x-www-form-urlencoded;charset=UTF-8'
        }
      )
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
        access_key_id: aws_access_key_id,
        secret_access_key: aws_secret_access_key
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
      access_token = scope ? retrieve_grantless_access_token : retrieve_lwa_access_token
      headers = {
        'x-amz-access-token' => access_token,
        'user-agent' => "MuffinMan/#{VERSION} (Language=Ruby)",
        'content-type' => "application/json"
      }
      signed_request.headers.merge(headers)
    end

    def derive_aws_region
      @aws_region ||= AWS_REGION_MAP[region]
      raise MuffinMan::Error.new("#{region} is not supported or does not exist. Region must be one of the following: #{AWS_REGION_MAP.keys.join(', ')}") unless @aws_region
      @aws_region
    end
  end
end
