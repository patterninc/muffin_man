# frozen_string_literal: true

RSpec.describe MuffinMan::VendorOrders::V1 do
  subject(:vendor_orders_client) { described_class.new(credentials) }

  before do
    stub_request_access_token
  end

  describe "get_purchase_orders" do
    let(:params) do
      {
        "limit" => 2,
        "createdAfter" => "2019-08-20T14:00:00",
        "createdBefore" => "2019-09-21T00:00:00",
        "sortOrder" => "DESC",
        "includeDetails" => true
      }
    end

    it "executes get_purchase_orders request" do
      stub_vendor_orders_v1_get_purchase_orders
      response = vendor_orders_client.get_purchase_orders(params)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)).to include(
        "payload" => {
          "pagination" => {
            "nextToken" => be_present
          },
          "orders" => be_present
        }
      )
    end
  end

  describe "get_purchase_order" do
    let(:purchase_order_number) { "4Z32PABC" }

    it "executes get_purchase_order request" do
      stub_vendor_orders_v1_get_purchase_order
      response = vendor_orders_client.get_purchase_order(purchase_order_number)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)).to include(
        "payload" => hash_including(
          "purchaseOrderNumber" => purchase_order_number,
          "purchaseOrderState" => be_present
        )
      )
    end
  end

  describe "submit_acknowledgement" do
    let(:acknowledgements) do
      [
        {
          "purchaseOrderNumber" => "TestOrder202",
          "sellingParty" => {
            "partyId" => "API01"
          },
          "acknowledgementDate" => "2021-03-12T17:35:26.308Z",
          "items" => [
            {
              "vendorProductIdentifier" => "028877454078",
              "orderedQuantity" => {
                "amount" => 10
              },
              "netCost" => {
                "amount" => "10.2"
              },
              "itemAcknowledgements" => [
                {
                  "acknowledgementCode" => "Accepted",
                  "acknowledgedQuantity" => {
                    "amount" => 10
                  }
                }
              ]
            }
          ]
        }
      ]
    end
    let(:payload) { { "transactionId" => "20190827182357-8725bde9-c61c-49f9-86ac-46efd82d4da5" } }

    it "executes submit_acknowledgement request" do
      stub_vendor_orders_v1_submit_acknowledgement
      response = vendor_orders_client.submit_acknowledgement(acknowledgements)
      expect(response.response_code).to eq(202)
      expect(JSON.parse(response.body)["payload"]).to eq payload
    end
  end

  describe "get_purchase_orders_status" do
    let(:params) do
      {
        "limit" => 1,
        "createdAfter" => "2020-08-17T14:00:00",
        "createdBefore" => "2020-08-18T00:00:00"
      }
    end

    it "executes get_purchase_orders_status request" do
      stub_vendor_orders_v1_get_purchase_orders_status
      response = vendor_orders_client.get_purchase_orders_status(params)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)).to include(
        "payload" => {
          "pagination" => {
            "nextToken" => be_present
          },
          "ordersStatus" => be_present
        }
      )
    end
  end
end
