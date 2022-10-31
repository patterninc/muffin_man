module MuffinMan
  module FbaInventory
    class V1 < SpApiClient

      GET_INVENTORY_SUMMARIES_PARAMS = %w[
        details
        granularityType
        granularityId
        startDateTime
        sellerSkus
        nextToken
        marketplaceIds
      ].freeze

      # NOTE: when passing nextToken, if the original request had a
      # startDateTime, that must be included in subsequent requests.
      def get_inventory_summaries(params)
        if sandbox
          params['granularityType'] = 'Marketplace'
          params['granularityId'] = 'ATVPDKIKX0DER'
          params['marketplaceIds'] = 'ATVPDKIKX0DER'
        end
        @local_var_path = "/fba/inventory/v1/summaries"
        @query_params = params.slice(*GET_INVENTORY_SUMMARIES_PARAMS)
        @request_type = "GET"
        call_api
      end
    end
  end
end
