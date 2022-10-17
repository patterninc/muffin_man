module MuffinMan
  module FulfillmentOutbound
    class V20200701 < SpApiClient

      # To get outbound fulfillment preview
      # @param [MuffinMan::RequestHelpers::OutboundFulFillment::FulfillmentPreviewRequest] fulfillment_preview_request in the form of object
      def get_fulfillment_preview(fulfillment_preview_request)
        @local_var_path = "/fba/outbound/2020-07-01/fulfillmentOrders/preview"
        @request_body = fulfillment_preview_request.to_camelize
        @request_type = "POST"
        call_api
      end

      # To create outbound fulfillment order
      # @param [MuffinMan::RequestHelpers::OutboundFulFillment::FulfillmentOrderRequest] fulfillment_order_request in the form of object
      def create_fulfillment_orders(fulfillment_order_request)
        @local_var_path = "/fba/outbound/2020-07-01/fulfillmentOrders"
        @request_body = fulfillment_order_request.to_camelize
        @request_type = "POST"
        call_api
      end

      # To get list of fulfillment orders
      # @param [String] query_start_date optional
      # @param [String] next_token optional
      def list_fulfillment_orders(query_start_date=nil,next_token=nil)
        @local_var_path = "/fba/outbound/2020-07-01/fulfillmentOrders"

        unless query_start_date.nil? && next_token.nil?
          @query_params = {}
        end

        @query_params[:queryStartDate] = query_start_date unless query_start_date.nil?
        @query_params[:nextToken] = next_token unless next_token.nil?
        @request_type = "GET"
        call_api
      end

      # To get fulfillment order
      # @param [String] seller_fulfillment_order_id
      def get_fulfillment_order(seller_fulfillment_order_id)
        @local_var_path = "/fba/outbound/2020-07-01/fulfillmentOrders/#{seller_fulfillment_order_id}"
        @request_type = "GET"
        call_api
      end

      # To cancel fulfillment order
      # @param [String] seller_fulfillment_order_id
      def cancel_fulfillment_order(seller_fulfillment_order_id)
        @local_var_path = "/fba/outbound/2020-07-01/fulfillmentOrders/#{seller_fulfillment_order_id}/cancel"
        @request_type = "PUT"
        call_api
      end
    end
  end
end

