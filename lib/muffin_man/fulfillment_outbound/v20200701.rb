module MuffinMan
  module FulfillmentOutbound
    class V20200701 < SpApiClient

      OPTIONAL_GET_FULFILLMENT_PARAMS = %w[
        marketplaceId
        shippingSpeedCategories
        includeCODFulfillmentPreview
        includeDeliveryWindows
        featureConstraints
      ].freeze

      OPTIONAL_CREATE_FULFILLMENT_ORDER_PARAMS = %w[
        marketplaceId
        deliveryWindow
        fulfillmentAction
        fulfillmentPolicy
        codSettings
        shipFromCountryCode
        notificationEmails
        featureConstraints
      ].freeze


      def get_fulfillment_preview(address, items, options={})
        @local_var_path = "/fba/outbound/2020-07-01/fulfillmentOrders/preview"
        @request_body = {
          "address" => address,
          "items" => items
        }

        @request_body.merge!(options.slice(*OPTIONAL_GET_FULFILLMENT_PARAMS)) unless options.nil?

        @request_type = "POST"
        call_api
      end

      def create_fulfillment_order(seller_fulfillment_order_id, displayable_order_id, displayable_order_date_time, displayable_order_comment, shipping_speed_category, destination_address, items, options={})
        @local_var_path = "/fba/outbound/2020-07-01/fulfillmentOrders"
        @request_body = {
          "sellerFulfillmentOrderId" => seller_fulfillment_order_id,
          "displayableOrderId" => displayable_order_id,
          "displayableOrderDate" => displayable_order_date_time,
          "displayableOrderComment" => displayable_order_comment,
          "shippingSpeedCategory" => shipping_speed_category,
          "destinationAddress" => destination_address,
          "items" => items
        }

        @request_body.merge!(options.slice(*OPTIONAL_CREATE_FULFILLMENT_ORDER_PARAMS)) unless options.nil?

        @request_type = "POST"

        call_api
      end

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


      def get_fulfillment_order(seller_fulfillment_order_id)
        @local_var_path = "/fba/outbound/2020-07-01/fulfillmentOrders/#{seller_fulfillment_order_id}"
        @request_type = "GET"
        call_api
      end

      def cancel_fulfillment_order(seller_fulfillment_order_id)
        @local_var_path = "/fba/outbound/2020-07-01/fulfillmentOrders/#{seller_fulfillment_order_id}/cancel"
        @request_type = "PUT"
        call_api
      end
    end
  end
end

