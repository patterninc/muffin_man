module MuffinMan
  module FulfillmentInbound
    class V1 < SpApiClient
      def get_item_eligibility_preview(asin, program, marketplace_ids: [])
        @local_var_path = "/fba/inbound/v1/eligibility/itemPreview"
        @query_params = {
          "asin" => asin,
          "program" => program,
        }
        @query_params["marketplaceIds"] = marketplace_ids.join(",") if marketplace_ids.any?
        @request_type = "GET"
        call_api
      end
    end
  end
end
