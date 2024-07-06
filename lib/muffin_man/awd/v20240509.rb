# frozen_string_literal: true

module MuffinMan
  module Awd
    class V20240509 < SpApiClient
      AWD_PATH = "/awd/2024-05-09"

      def get_inbound_shipment(shipment_id)
        @local_var_path = "#{AWD_PATH}/inboundShipments/#{shipment_id}"
        @request_type = "GET"
        call_api
      end
    end
  end
end
