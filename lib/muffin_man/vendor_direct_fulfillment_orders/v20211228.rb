# frozen_string_literal: true

module MuffinMan
  module VendorDirectFulfillmentOrders
    class V20211228 < SpApiClient
      GET_ORDERS_PARAMS = %w[
        shipFromPartyId
        status
        limit
        sortOrder
        nextToken
        includeDetails
      ].freeze

      def get_orders(created_after, created_before, params = {})
        @local_var_path = "/vendor/directFulfillment/orders/2021-12-28/purchaseOrders"
        @query_params = {
          "createdAfter" => created_after,
          "createdBefore" => created_before
        }
        @query_params.merge!(params.slice(*GET_ORDERS_PARAMS))
        @request_type = "GET"
        call_api
      end

      def get_order(purchase_order_number)
        @local_var_path = "/vendor/directFulfillment/orders/2021-12-28/purchaseOrders/#{purchase_order_number}"
        @request_type = "GET"
        call_api
      end

      def submit_acknowledgement(order_acknowledgements)
        @local_var_path = "/vendor/directFulfillment/orders/2021-12-28/acknowledgements"
        @request_body = { "orderAcknowledgements" => order_acknowledgements }
        @request_type = "POST"
        call_api
      end
    end
  end
end
