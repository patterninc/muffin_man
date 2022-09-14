module MuffinMan
  module FulfillmentInbound
    class V0 < SpApiClient
      def get_prep_instructions(ship_to_country_code, seller_sku_list: [], asin_list: [])
        @local_var_path = "/fba/inbound/v0/prepInstructions"
        @query_params = {
          "ShipToCountryCode" => ship_to_country_code
        }
        @query_params["SellerSKUList"] = seller_sku_list.join(",") if seller_sku_list.any?
        @query_params["ASINList"] = asin_list.join(",") if asin_list.any?
        @request_type = "GET"
        call_api
      end
    end
  end
end
