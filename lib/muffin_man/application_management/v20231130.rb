# frozen_string_literal: true

module MuffinMan
  module ApplicationManagement
    class V20231130
      def self.rotate_application_client_secret(access_token)
        Typhoeus.post(
          "https://sellingpartnerapi-na.amazon.com/applications/2023-11-30/clientSecret",
          headers: {
             "x-amz-access-token" => access_token,
              "Content-Type" => "application/json;charset=UTF-8"
            }
        )
      end
    end
  end
end
