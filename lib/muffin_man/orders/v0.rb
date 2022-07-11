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

      def get_orders(marketplace_ids, params = {})
        @local_var_path = "/orders/v0/orders"
        @query_params = params.slice(*GET_ORDERS_PARAMS)
        @query_params["MarketplaceIds"] = marketplace_ids # try multiple at once.
        @request_type = "GET"
        call_api
      end

      def get_order_items(order_id, next_token = nil)
        @query_params = {"NextToken" => next_token} unless next_token.nil? 
        @local_var_path = "/orders/v0/orders/#{order_id}/orderItems"
        @request_type = "GET"
        call_api
      end






      def get_order(order_id)
        @local_var_path = "/orders/v0/orders/#{order_id}"
        @request_type = "GET"
        call_api
      end

      def get_order_buyer_info(order_id)
        @local_var_path = "/orders/v0/orders/#{order_id}/buyerInfo"
        @request_type = "GET"
        call_api
      end

      def get_order_address(order_id)
        @local_var_path = "/orders/v0/orders/#{order_id}/address"
        @request_type = "GET"
        call_api
      end

      def get_order_items_buyer_info(order_id, next_token = nil)
        @query_params = {"NextToken" => next_token} unless next_token.nil? 
        @local_var_path = "/orders/v0/orders/#{order_id}/orderItems/buyerInfo"
        @request_type = "GET"
        call_api
      end

      def update_shipment_status(order_id, marketplace_id, shipment_status, order_items={})
        @local_var_path = "/orders/v0/orders/#{order_id}/shipment"
        @request_body = {
          "marketplaceIds" => marketplace_id,
          "shipmentStatus" => shipment_status
        }
        @request_body["orderItems"] = order_items unless order_items.empty?
      end

      def get_order_regulated_info(order_id)
        @local_var_path = "/orders/v0/orders/#{order_id}/regulatedInfo"
        @request_type = "GET" 
        call_api
      end

      def update_verification_status(order_id, regulated_order_verification_status)
        @request_body = {"regulatedOrderVerificationStatus" => regulated_order_verification_status}  # UpdateVerificationStatusRequest or regulatedOrderVerificationStatus or both?
        @local_var_path = "/orders/v0/orders/#{order_id}/regulatedInfo"
        @request_type = "PATCH" # Do I need to use PUT instead?
        call_api
      end

    end
  end
end