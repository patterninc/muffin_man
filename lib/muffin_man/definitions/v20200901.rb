module MuffinMan
  module Definitions
    class V20200901 < SpApiClient
      def search_definitions_product_types(marketplace_ids, keywords: nil)
        @local_var_path = "/definitions/2020-09-01/productTypes"
        @marketplace_ids = marketplace_ids.is_a?(Array) ? marketplace_ids : [marketplace_ids]
        @keywords = keywords.is_a?(Array) ? keywords : [keywords]
        @query_params = { marketplaceIds: @marketplace_ids.join(",") }
        @query_params["keywords"] = @keywords.join(",") if keywords
        @request_type = "GET"
        call_api
      end

      def get_definitions_product_type(product_type, marketplace_ids, seller_id: nil, product_type_version: nil,
                                       requirements: nil, requirements_enforced: nil, locale: nil)
        @local_var_path = "/definitions/2020-09-01/productTypes/#{product_type}"
        @marketplace_ids = marketplace_ids.is_a?(Array) ? marketplace_ids : [marketplace_ids]
        @query_params = { marketplaceIds: @marketplace_ids.join(",") }
        @query_params["sellerId"] = seller_id if seller_id
        @query_params["productTypeVersion"] = product_type_version if product_type_version
        @query_params["requirements"] = requirements.join(",") if requirements
        @query_params["requirementsEnforced"] = requirements_enforced if requirements_enforced
        @query_params["locale"] = locale if locale
        @request_type = "GET"
        call_api
      end
    end
  end
end
