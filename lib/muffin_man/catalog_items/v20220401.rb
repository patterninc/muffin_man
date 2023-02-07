require "muffin_man/catalog_items/base_api"

module MuffinMan
  module CatalogItems
    class V20220401 < BaseApi
      SEARCH_CATALOG_ITEMS_PARAMS = %w(
        identifiersType
        sellerId
      ).freeze

      API_VERSION = "2022-04-01".freeze

      def search_catalog_items(marketplace_ids, params = {})
        super(params["keywords"] || params["identifiers"], marketplace_ids, params, API_VERSION)
      end

      def get_catalog_item(asin, marketplace_ids, params = {})
        super(asin, marketplace_ids, params, API_VERSION)
      end
    end
  end
end
