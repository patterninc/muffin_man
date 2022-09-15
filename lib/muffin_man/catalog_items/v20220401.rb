module MuffinMan
  module CatalogItems
    class V20220401 < V20201201

      def search_catalog_items(keywords, marketplace_ids, params = {})
        super(keywords, marketplace_ids, params, "2022-04-01")
      end

      def get_catalog_item(asin, marketplace_ids, params = {})
        super(asin, marketplace_ids, params, "2022-04-01")
      end
    end
  end
end
