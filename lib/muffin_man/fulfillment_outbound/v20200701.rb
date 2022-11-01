# frozen_string_literal: true

module MuffinMan
  module FulfillmentOutbound
    class V20200701 < SpApiClient
      # @param [MuffinMan::RequestHelpers::OutboundFulFillment::FulfillmentPreviewRequest] fulfillment_preview_request in the form of object
      def get_fulfillment_preview(fulfillment_preview_request)
        return unprocessable_entity(fulfillment_preview_request&.errors) unless fulfillment_preview_request&.valid?

        @local_var_path = "/fba/outbound/2020-07-01/fulfillmentOrders/preview"
        @request_body = fulfillment_preview_request.to_camelize
        @request_type = "POST"
        call_api
      end

      # @param [MuffinMan::RequestHelpers::OutboundFulFillment::FulfillmentOrderRequest] fulfillment_order_request in the form of object
      def create_fulfillment_order(fulfillment_order_request)
        return unprocessable_entity(fulfillment_order_request&.errors) unless fulfillment_order_request&.valid?

        @local_var_path = "/fba/outbound/2020-07-01/fulfillmentOrders"
        @request_body = fulfillment_order_request.to_camelize
        @request_type = "POST"
        call_api
      end

      # @param [String] query_start_date optional
      # @param [String] next_token optional
      def list_all_fulfillment_orders(query_start_date: nil, next_token: nil)
        @local_var_path = "/fba/outbound/2020-07-01/fulfillmentOrders"

        @query_params = {} unless query_start_date.nil? && next_token.nil?

        @query_params[:queryStartDate] = query_start_date unless query_start_date.nil?
        @query_params[:nextToken] = next_token unless next_token.nil?
        @request_type = "GET"
        call_api
      end

      # @param [String] seller_fulfillment_order_id
      def get_fulfillment_order(seller_fulfillment_order_id)
        @local_var_path = "/fba/outbound/2020-07-01/fulfillmentOrders/#{seller_fulfillment_order_id}"
        @request_type = "GET"
        call_api
      end

      # @param [String] seller_fulfillment_order_id
      def cancel_fulfillment_order(seller_fulfillment_order_id)
        @local_var_path = "/fba/outbound/2020-07-01/fulfillmentOrders/#{seller_fulfillment_order_id}/cancel"
        @request_type = "PUT"
        call_api
      end
    end
  end
end
