module MuffinMan::ApiAccountCredential 
  class CredentialHelper
    NEW_APP_CREDENTIAL_URL = "https://sellingpartnerapi-na.amazon.com/applications/2023-11-30/clientSecret".freeze

    def self.create_new_credentials(access_token)
      response = Typhoeus.post(
        NEW_APP_CREDENTIAL_URL,
        headers: {
          "x-amz-access-token" => "#{access_token}"
        }
      )
      if response.code != 204
        error_body = JSON.parse(response.body)
        error = "#{error_body['error']}: #{error_body['error_description']} "
        raise MuffinMan::Error, error
      end
      response.code
    end
  end
end