require "muffin_man/catalog_items/base_api"

module MuffinMan
  module CatalogItems
    class V20220401 < BaseApi

      API_VERSION = "2022-04-01".freeze

      def search_catalog_items(keywords, marketplace_ids, params = {})
        super(keywords, marketplace_ids, params, API_VERSION)
      end

      def get_catalog_item(asin, marketplace_ids, params = {})
        super(asin, marketplace_ids, params, API_VERSION)
      end
    end
  end
end
