module MuffinMan
  module Authorization
    class V1 < SpApiClient
      def get_authorization_code(selling_partner_id, developer_id, mws_auth_token)
        @query_params = {
          "sellingPartnerId" => selling_partner_id,
          "developerId" => developer_id,
          "mwsAuthToken" => mws_auth_token
        }
        @request_type = "GET"
        @local_var_path = "/authorization/v1/authorizationCode"
        call_api
      end
    end
  end
end
