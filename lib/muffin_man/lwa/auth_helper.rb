module MuffinMan::Lwa
  class AuthHelper
    ACCESS_TOKEN_URL = "https://api.amazon.com/auth/o2/token".freeze

    def self.get_refresh_token(client_id, client_secret, auth_code)
      body = {
        grant_type: "authorization_code",
        code: auth_code,
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
      if response.code != 200
        error_body = JSON.parse(response.body)
        error = "#{error_body["error"]}: #{error_body["error_description"]}"
        raise MuffinMan::Error, error
      end
      JSON.parse(response.body)["refresh_token"]
    end

    def self.get_client_credential_refresh_token(client_id, client_secret)
      body = {
        grant_type: "client_credentials",
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
      if response.code != 200
        error_body = JSON.parse(response.body)
        error = "#{error_body["error"]}: #{error_body["error_description"]}"
        raise MuffinMan::Error, error
      end
      JSON.parse(response.body)["refresh_token"]
    end
  end
end
