module MuffinMan
  module Listings
    class V20210801 < SpApiClient
      def get_listings_item(seller_id, sku, marketplace_ids, issue_locale: nil, included_data: [])
        # Options for included_data:
        #   summaries
        #   attributes
        #   issues
        #   offers
        #   fulfillmentAvailability
        #   procurement
        @local_var_path = "/listings/2021-08-01/items/#{seller_id}/#{sku}"
        @marketplace_ids = marketplace_ids.is_a?(Array) ? marketplace_ids : [marketplace_ids]
        @query_params = {
          "marketplaceIds" =>  @marketplace_ids.join(",")
        }
        @query_params["issueLocale"] = issue_locale if issue_locale
        @query_params["includedData"] = included_data.join(",") if included_data.any?
        @request_type = "GET"
        call_api
      end
    end
  end
end
