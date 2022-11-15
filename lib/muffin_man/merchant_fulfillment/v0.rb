# frozen_string_literal: true

module MuffinMan
  module MerchantFulfillment
    class V0 < SpApiClient
      def get_eligible_shipment_services(shipment_request_details, shipping_offering_filter = {})
        @local_var_path = "/mfn/v0/eligibleShippingServices"
        @request_body = {
          "ShipmentRequestDetails" => shipment_request_details
        }
        @request_body["ShippingOfferingFilter"] = shipping_offering_filter unless shipping_offering_filter.empty?
        @request_type = "POST"
        call_api
      end

      def get_shipment(shipment_id)
        @local_var_path = "/mfn/v0/shipments/#{shipment_id}"
        @request_type = "GET"
        call_api
      end

      CANCEL_SANDBOX_SHIPMENT_ID = "be7a0a53-00c3-4f6f-a63a-639f76ee9253"
      def cancel_shipment(shipment_id)
        shipment_id = CANCEL_SANDBOX_SHIPMENT_ID if sandbox
        @local_var_path = "/mfn/v0/shipments/#{shipment_id}"
        @request_type = "DELETE"
        call_api
      end

      def create_shipment(shipment_request_details, shipping_service_id,
                          shipping_service_offering_id: nil, hazmat_type: nil, label_format_option: {},
                          shipment_level_seller_inputs_list: [])
        @local_var_path = "/mfn/v0/shipments"
        @request_body = {
          "ShipmentRequestDetails" => shipment_request_details,
          "ShippingServiceId" => shipping_service_id
        }
        @request_body["ShippingServiceOfferId"] = shipping_service_offering_id unless shipping_service_offering_id.nil?
        @request_body["HazmatType"] = hazmat_type unless hazmat_type.nil?
        @request_body["LabelFormatOption"] = label_format_option unless label_format_option.empty?
        if shipment_level_seller_inputs_list.any?
          @request_body["ShipmentLevelSellerInputsList"] = shipment_level_seller_inputs_list
        end
        if sandbox
          @request_body = JSON.parse(
            File.read(
              File.expand_path(
                "../sandbox_helpers/merchant_fulfillment/create_shipment_body.json",
                File.dirname(__FILE__)
              )
            )
          )
        end
        @request_type = "POST"
        call_api
      end

      def get_additional_seller_inputs(shipping_service_id, ship_from_address, order_id)
        @local_var_path = "/mfn/v0/additionalSellerInputs"
        @request_body = {
          "ShippingServiceId" => shipping_service_id,
          "ShipFromAddress" => ship_from_address,
          "OrderId" => order_id
        }
        @request_type = "POST"
        call_api
      end
    end
  end
end
