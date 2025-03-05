# frozen_string_literal: true

module MuffinMan
  module VendorShipments
    class V1 < SpApiClient
      GET_SHIPMENT_DETAILS_PARAMS = %w[
        limit
        sortOrder
        nextToken
        createdAfter
        createdBefore
        shipmentConfirmedBefore
        shipmentConfirmedAfter
        packageLabelCreatedBefore
        packageLabelCreatedAfter
        shippedBefore
        shippedAfter
        estimatedDeliveryBefore
        estimatedDeliveryAfter
        shipmentDeliveryBefore
        shipmentDeliveryAfter
        requestedPickUpBefore
        requestedPickUpAfter
        scheduledPickUpBefore
        scheduledPickUpAfter
        currentShipmentStatus
        vendorShipmentIdentifier
        buyerReferenceNumber
        buyerWarehouseCode
        sellerWarehouseCode
      ].freeze

      def submit_shipment_confirmations(shipment_confirmations)
        @local_var_path = "/vendor/shipping/v1/shipmentConfirmations"
        @request_body = { "shipmentConfirmations" => shipment_confirmations }
        @request_type = "POST"
        call_api
      end

      def get_shipment_details(params = {})
        @local_var_path = "/vendor/shipping/v1/shipments"
        @query_params = params.slice(*GET_SHIPMENT_DETAILS_PARAMS)
        @request_type = "GET"
        call_api
      end

      def submit_shipments(shipments)
        @local_var_path = "/vendor/shipping/v1/shipments"
        @request_body = { "shipments" => shipments }
        @request_type = "POST"
        call_api
      end
    end
  end
end
