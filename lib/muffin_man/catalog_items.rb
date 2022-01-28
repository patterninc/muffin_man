module MuffinMan
  class CatalogItems < SpApiClient
    INCLUDED_DATE_VALUES = %w[
      attributes
      identifiers
      images
      productTypes
      salesRanks
      summaries
      variations
      vendorDetails
    ]

    def get_catalog_item(asin, marketplace_ids, included_data = nil, locale = nil)
      @local_var_path = "/catalog/2020-12-01/items/#{asin}"
      @query_params = { "marketplaceIds" => marketplace_ids.join(',') }
      @query_params["includedData"] = included_data.join(',') if included_data.is_a?(Array)
      @query_params["locale"] = locale if locale.is_a?(String)
      @request_type = 'GET'
      call_api
    end
  end
end
