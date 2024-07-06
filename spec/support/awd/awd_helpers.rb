# frozen_string_literal: true

module Support
  module Awd
    module AwdHelpers
      def stub_get_inbound_shipment(shipment_id)
        stub_request(:get, "https://#{hostname}/awd/2024-05-09/inboundShipments/#{shipment_id}")
          .to_return(
            status: 200,
            body: File.read("./spec/support/awd/get_inbound_shipment.json"),
            headers: {}
          )
      end
    end
  end
end
