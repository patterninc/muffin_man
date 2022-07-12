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

      def get_orders(marketplace_ids, params = {})
        @local_var_path = "/orders/v0/orders"
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


      # def get_order_items(order_id, next_token = nil)
      #   @query_params = {"NextToken" => next_token} unless next_token.nil? 
      #   @local_var_path = "/orders/v0/orders/#{order_id}/orderItems"
      #   @request_type = "GET"
      #   call_api
      # end
    end
  end
end