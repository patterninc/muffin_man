module MuffinMan
  module V20201201
    class CatalogItems < SpApiClient
      SEARCH_CATALOG_ITEMS_PARAMS = %w[
        includedData
        brandNames
        classificationIds
        pageSize
        pageToken
        keywordsLocale
        locale
      ].freeze
      GET_CATALOG_ITEM_PARAMS = %w[includeData locale].freeze

      def search_catalog_items(keywords, marketplace_ids, params = {})
        @local_var_path = "/catalog/2020-12-01/items"
        keywords = [keywords] unless keywords.is_a?(Array)
        marketplace_ids = [marketplace_ids] unless marketplace_ids.is_a?(Array)
        @query_params = {
          "keywords" => keywords.join(","),
          "marketplaceIds" => marketplace_ids.join(",")
        }
        @query_params.merge!(params.slice(*SEARCH_CATALOG_ITEMS_PARAMS))
        @request_type = "GET"
        call_api
      end

      def get_catalog_item(asin, marketplace_ids, params = {})
        @local_var_path = "/catalog/2020-12-01/items/#{asin}"
        marketplace_ids = [marketplace_ids] unless marketplace_ids.is_a?(Array)
        @query_params = { "marketplaceIds" => marketplace_ids.join(",") }
        @query_params.merge!(params.slice(*GET_CATALOG_ITEM_PARAMS))
        @request_type = "GET"
        call_api
      end
    end
  end
end
