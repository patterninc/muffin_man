module MuffinMan
  module CatalogItems
    class V20220401 < V20201201

      def search_catalog_items(keywords, marketplace_ids, params = {})
        if sandbox
          keywords = SANDBOX_KEYWORDS
          marketplace_ids = SANDBOX_MARKETPLACE_IDS
          params = {}
        end
        @keywords = keywords.is_a?(Array) ? keywords : [keywords]
        @marketplace_ids = marketplace_ids.is_a?(Array) ? marketplace_ids : [marketplace_ids]
        @params = params
        @local_var_path = "/catalog/2022-04-01/items"
        @query_params = {
          "keywords" => @keywords.join(","),
          "marketplaceIds" => @marketplace_ids.join(",")
        }
        @query_params.merge!(@params.slice(*SEARCH_CATALOG_ITEMS_PARAMS))
        @request_type = "GET"
        call_api
      end

      def get_catalog_item(asin, marketplace_ids, params = {})
        if sandbox
          asin = SANDBOX_ASIN
          marketplace_ids = SANDBOX_MARKETPLACE_IDS
          params = {}
        end
        @asin = asin
        @marketplace_ids = marketplace_ids.is_a?(Array) ? marketplace_ids : [marketplace_ids]
        @params = params
        @local_var_path = "/catalog/2022-04-01/items/#{@asin}"
        @query_params = { "marketplaceIds" => @marketplace_ids.join(",") }
        @query_params.merge!(@params.slice(*GET_CATALOG_ITEM_PARAMS))
        @request_type = "GET"
        call_api
      end
    end
  end
end
