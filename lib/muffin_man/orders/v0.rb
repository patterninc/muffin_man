module MuffinMan
  module Orders
    class V0 < SpApiClient
      GET_ORDERS_PARAMS = %w[
        CreatedAfter
        CreatedBefore
        LastUpdatedAfter
        LastUpdatedBefore
        OrderStatuses
        FulfillmentChannels
        PaymentMethods
        BuyerEmail
        SellerOrderId
        MaxResultsPerPage
        EasyShipShipmentStatuses
        NextToken
        AmazonOrderIds
        ActualFulfillmentSupplySourceId
        IsISPU
        StoreChainStoreId
      ].freeze

      GET_ORDER_ITEMS_PARAMS = %w[
        NextToken
      ].freeze

      PII_DATA_ELEMENTS = %w[
        buyerInfo shippingAddress buyerTaxInformation
      ].freeze

      def get_orders(marketplace_ids, params = {}, pii_data_elements: [])
        @local_var_path = "/orders/v0/orders"
        @pii_data_elements = pii_data_elements & PII_DATA_ELEMENTS
        @query_params = params.slice(*GET_ORDERS_PARAMS)
        @query_params["MarketplaceIds"] = marketplace_ids
        @request_type = "GET"
        call_api
      end

      def get_order_items(order_id, params = {})
        @query_params = params.slice(*GET_ORDER_ITEMS_PARAMS)
        @local_var_path = "/orders/v0/orders/#{order_id}/orderItems"
        @request_type = "GET"
        call_api
      end

      def get_order_address(order_id)
        @local_var_path = "/orders/v0/orders/#{order_id}/address"
        @request_type = "GET"
        call_api
      end
    end
  end
end
