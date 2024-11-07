module MuffinMan
  module Finances
    class V20240619 < SpApiClient
      def list_transactions(posted_after:, posted_before: nil, marketplace_id: nil, next_token: nil)
        @local_var_path = "/finances/2024-06-19/transactions"
        @query_params = {
          "postedAfter" => posted_after
        }
        @query_params["PostedBefore"] = posted_before unless posted_before.nil?
        @query_params["marketplaceId"] = marketplace_id unless marketplace_id.nil?
        @query_params["nextToken"] = next_token unless next_token.nil?
        @request_type = "GET"
        call_api
      end
    end
  end
end
