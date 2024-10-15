# frozen_string_literal: true

RSpec.describe MuffinMan::VendorShipments::V1 do
  subject(:vendor_shipments_client) { described_class.new(credentials) }

  let(:payload) { { "transactionId" => "20190905010908-8a3b6901-ef20-412f-9270-21c021796605" } }

  before do
    stub_request_access_token
  end

  describe "submit_shipment_confirmations" do
    let(:shipment_confirmations) do
      [
        {
          "shipmentIdentifier" => "TestShipmentConfirmation202",
          "shipmentConfirmationDate" => "2021-03-11T12:38:23.388Z",
          "sellingParty" => {
            "partyId" => "ABCD1"
          },
          "shipFromParty" => {
            "partyId" => "EFGH1"
          },
          "shipToParty" => {
            "partyId" => "JKL1"
          },
          "shipmentConfirmationType" => "Original",
          "shippedItems" => [
            {
              "itemSequenceNumber" => "001",
              "shippedQuantity" => {
                "amount" => 100,
                "unitOfMeasure" => "Eaches"
              }
            }
          ]
        }
      ]
    end

    it "executes submit_shipment_confirmations request" do
      stub_vendor_shipments_v1_submit_shipment_confirmations
      response = vendor_shipments_client.submit_shipment_confirmations(shipment_confirmations)
      expect(response.response_code).to eq(202)
      expect(JSON.parse(response.body)["payload"]).to eq payload
    end
  end

  describe "get_shipment_details" do
    let(:params) { { "vendorShipmentIdentifier" => "12345678" } }

    it "executes get_shipment_details request" do
      stub_vendor_shipments_v1_get_shipment_details
      response = vendor_shipments_client.get_shipment_details(params)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)).to include(
        "payload" => {
          "pagination" => {
            "nextToken" => be_present
          },
          "shipments" => be_present
        }
      )
    end
  end

  describe "submit_shipments" do
    let(:shipments) do
      [
        {
          "vendorShipmentIdentifier" => "00050003",
          "transactionType" => "New",
          "transactionDate" => "2019-08-07T19:56:45.632",
          "sellingParty" => {
            "partyId" => "PQRSS"
          },
          "shipFromParty" => {
            "partyId" => "999US"
          },
          "shipToParty" => {
            "partyId" => "ABCDF"
          }
        }
      ]
    end

    it "executes submit_shipments request" do
      stub_vendor_shipments_v1_submit_shipments
      response = vendor_shipments_client.submit_shipments(shipments)
      expect(response.response_code).to eq(202)
      expect(JSON.parse(response.body)["payload"]).to eq payload
    end
  end
end
