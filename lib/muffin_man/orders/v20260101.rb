# frozen_string_literal: true

module MuffinMan
  module Orders
    class V20260101 < SpApiClient
      SEARCH_ORDERS_QUERY_PARAMS = %w[
        createdAfter
        createdBefore
        lastUpdatedAfter
        lastUpdatedBefore
        fulfillmentStatuses
        marketplaceIds
        fulfilledBy
        maxResultsPerPage
        paginationToken
        includedData
      ].freeze

      def search_orders(query_params: {})
        @local_var_path = "/orders/2026-01-01/orders"
        @query_params = query_params.slice(*SEARCH_ORDERS_QUERY_PARAMS)
        @request_type = "GET"
        call_api
      end

      def get_order(order_id, included_data: [])
        @local_var_path = "/orders/2026-01-01/orders/#{order_id}"
        @query_params = {}
        @query_params["includedData"] = included_data.join(",") if included_data.any?
        @request_type = "GET"
        call_api
      end
    end
  end
end
