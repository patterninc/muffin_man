module MuffinMan
  module Tokens
    class V20210301 < SpApiClient
      def create_restricted_data_token(path, method, data_elements, target_application: nil)
        @local_var_path = "/tokens/2021-03-01/restrictedDataToken"
        @request_body = {}
        @request_body["targetApplication"] = target_application unless target_application.nil?
        restricted_resources = {
          "method" => method,
          "path" => path,
          "dataElements" => data_elements
        }
        @request_body["restrictedResources"] = [restricted_resources]
        @request_type = "POST"
        call_api
      end
    end
  end
end
