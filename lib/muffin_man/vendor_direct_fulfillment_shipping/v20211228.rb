# frozen_string_literal: true

module MuffinMan
  module VendorDirectFulfillmentShipping
    class V20211228 < SpApiClient
      VENDOR_DIRECT_FULFILLMENT_SHIPPING_PARAMS = %w[
        shipFromPartyId
        limit
        sortOrder
        nextToken
      ].freeze

      def get_shipping_labels(created_after, created_before, params = {})
        @local_var_path = "/vendor/directFulfillment/shipping/2021-12-28/shippingLabels"
        @query_params = {
          "createdAfter" => created_after,
          "createdBefore" => created_before
        }
        @query_params.merge!(params.slice(*VENDOR_DIRECT_FULFILLMENT_SHIPPING_PARAMS))
        @request_type = "GET"
        call_api
      end

      def submit_shipping_label_request(shipping_label_requests)
        @local_var_path = "/vendor/directFulfillment/shipping/2021-12-28/shippingLabels"
        @request_body = { "shippingLabelRequests" => shipping_label_requests }
        @request_type = "POST"
        call_api
      end

      def get_shipping_label(purchase_order_number)
        @local_var_path = "/vendor/directFulfillment/shipping/2021-12-28/shippingLabels/#{purchase_order_number}"
        @request_type = "GET"
        call_api
      end

      def create_shipping_labels(purchase_order_number, selling_party, ship_from_party, containers)
        @local_var_path = "/vendor/directFulfillment/shipping/2021-12-28/shippingLabels/#{purchase_order_number}"
        @request_body = {
          "sellingParty" => selling_party,
          "shipFromParty" => ship_from_party,
          "containers" => containers
        }
        @request_type = "POST"
        call_api
      end

      def submit_shipment_confirmations(shipment_confirmations)
        @local_var_path = "/vendor/directFulfillment/shipping/2021-12-28/shipmentConfirmations"
        @request_body = { "shipmentConfirmations" => shipment_confirmations }
        @request_type = "POST"
        call_api
      end

      def submit_shipment_status_updates(shipment_status_updates)
        @local_var_path = "/vendor/directFulfillment/shipping/2021-12-28/shipmentStatusUpdates"
        @request_body = { "shipmentStatusUpdates" => shipment_status_updates }
        @request_type = "POST"
        call_api
      end

      def get_customer_invoices(created_after, created_before, params = {})
        @local_var_path = "/vendor/directFulfillment/shipping/2021-12-28/customerInvoices"
        @query_params = {
          "createdAfter" => created_after,
          "createdBefore" => created_before
        }
        @query_params.merge!(params.slice(*VENDOR_DIRECT_FULFILLMENT_SHIPPING_PARAMS))
        @request_type = "GET"
        call_api
      end

      def get_customer_invoice(purchase_order_number)
        @local_var_path = "/vendor/directFulfillment/shipping/2021-12-28/customerInvoices/#{purchase_order_number}"
        @request_type = "GET"
        call_api
      end

      def get_packing_slips(created_after, created_before, params = {})
        @local_var_path = "/vendor/directFulfillment/shipping/2021-12-28/packingSlips"
        @query_params = {
          "createdAfter" => created_after,
          "createdBefore" => created_before
        }
        @query_params.merge!(params.slice(*VENDOR_DIRECT_FULFILLMENT_SHIPPING_PARAMS))
        @request_type = "GET"
        call_api
      end

      def get_packing_slip(purchase_order_number)
        @local_var_path = "/vendor/directFulfillment/shipping/2021-12-28/packingSlips/#{purchase_order_number}"
        @request_type = "GET"
        call_api
      end
    end
  end
end
