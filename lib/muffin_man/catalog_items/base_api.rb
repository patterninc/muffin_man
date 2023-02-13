module MuffinMan
  module CatalogItems
    class BaseApi < SpApiClient
      SANDBOX_KEYWORDS = "shoes".freeze
      SANDBOX_ASIN = "B07N4M94X4".freeze
      SANDBOX_MARKETPLACE_IDS = "ATVPDKIKX0DER".freeze
      attr_reader :keywords, :asin, :marketplace_ids, :params

      SEARCH_CATALOG_ITEMS_PARAMS = [].freeze
      BASE_SEARCH_CATALOG_ITEMS_PARAMS = %w[
        includedData
        brandNames
        classificationIds
        pageSize
        pageToken
        keywordsLocale
        locale
      ].freeze
      GET_CATALOG_ITEM_PARAMS = %w[includedData locale].freeze

      API_VERSION = "2020-12-01".freeze

      def search_catalog_items(keywords, marketplace_ids, params = {}, api_version=API_VERSION)
        if sandbox
          keywords = SANDBOX_KEYWORDS
          marketplace_ids = SANDBOX_MARKETPLACE_IDS
          params = {}
        end
        @keywords = keywords.is_a?(Array) ? keywords : [keywords]
        @identifiers = params["identifiers"].is_a?(Array) ? params["identifiers"] : [params["identifiers"]]
        @marketplace_ids = marketplace_ids.is_a?(Array) ? marketplace_ids : [marketplace_ids]
        @params = params
        @local_var_path = "/catalog/#{api_version}/items"
        @query_params = {
          "marketplaceIds" => @marketplace_ids.join(",")
        }
        @query_params["keywords"] = @keywords.join(",") if @keywords.any?
        @query_params["identifiers"] = @identifiers.join(",") if @identifiers.any?
        @query_params["identifiersType"] = params["identifiersType"] || "ASIN" if @identifiers.any?
        @query_params.merge!(@params.slice(*search_catalog_items_params))
        @request_type = "GET"
        call_api
      end

      def get_catalog_item(asin, marketplace_ids, params = {}, api_version=API_VERSION)
        if sandbox
          asin = SANDBOX_ASIN
          marketplace_ids = SANDBOX_MARKETPLACE_IDS
          params = {}
        end
        @asin = asin
        @marketplace_ids = marketplace_ids.is_a?(Array) ? marketplace_ids : [marketplace_ids]
        @params = params
        @local_var_path = "/catalog/#{api_version}/items/#{@asin}"
        @query_params = { "marketplaceIds" => @marketplace_ids.join(",") }
        @query_params.merge!(@params.slice(*GET_CATALOG_ITEM_PARAMS))
        @request_type = "GET"
        call_api
      end

      private

      def search_catalog_items_params
        BASE_SEARCH_CATALOG_ITEMS_PARAMS + self.class::SEARCH_CATALOG_ITEMS_PARAMS
      end
    end
  end
end
