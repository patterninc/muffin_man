# frozen_string_literal: true

RSpec.describe MuffinMan::Awd::V20240509 do
  before do
    stub_request_access_token
  end

  let(:awd_client) { described_class.new(credentials) }

  describe "get_inbound_shipment" do
    subject(:get_inbound_shipment) { awd_client.get_inbound_shipment(shipment_id) }

    let(:shipment_id) { "FBA12345" }
    let!(:get_inbound_shipment_stub) { stub_get_inbound_shipment(shipment_id) }

    it "makes a request to get shipment by shipment ID" do
      get_inbound_shipment
      expect(get_inbound_shipment_stub).to have_been_requested
    end
  end
end
