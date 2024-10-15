# frozen_string_literal: true

module MuffinMan
  module VendorOrders
    class V1 < SpApiClient
      GET_PURCHASE_ORDERS_PARAMS = %w[
        limit
        createdAfter
        createdBefore
        sortOrder
        nextToken
        includeDetails
        changedAfter
        changedBefore
        poItemState
        isPOChanged
        purchaseOrderState
        orderingVendorCode
      ].freeze

      GET_PURCHASE_ORDERS_STATUS_PARAMS = %w[
        limit
        sortOrder
        nextToken
        createdAfter
        createdBefore
        updatedAfter
        updatedBefore
        purchaseOrderNumber
        purchaseOrderStatus
        itemConfirmationStatus
        itemReceiveStatus
        orderingVendorCode
        shipToPartyId
      ].freeze

      def get_purchase_orders(params = {})
        @local_var_path = "/vendor/orders/v1/purchaseOrders"
        @query_params = params.slice(*GET_PURCHASE_ORDERS_PARAMS)
        @request_type = "GET"
        call_api
      end

      def get_purchase_order(purchase_order_number)
        @local_var_path = "/vendor/orders/v1/purchaseOrders/#{purchase_order_number}"
        @request_type = "GET"
        call_api
      end

      def submit_acknowledgement(acknowledgements)
        @local_var_path = "/vendor/orders/v1/acknowledgements"
        @request_body = { "acknowledgements" => acknowledgements }
        @request_type = "POST"
        call_api
      end

      def get_purchase_orders_status(params = {})
        @local_var_path = "/vendor/orders/v1/purchaseOrdersStatus"
        @query_params = params.slice(*GET_PURCHASE_ORDERS_STATUS_PARAMS)
        @request_type = "GET"
        call_api
      end
    end
  end
end
