# frozen_string_literal: true

RSpec.describe MuffinMan::VendorDirectFulfillmentOrders::V20211228 do
  subject(:vendor_direct_fulfillment_orders_client) { described_class.new(credentials) }

  before do
    stub_request_access_token
  end

  describe "get_orders" do
    let(:created_after) { "2020-02-15T14:00:00-08:00" }
    let(:created_before) { "2020-02-20T00:00:00-08:00" }
    let(:params) do
      {
        "limit" => 2,
        "sortOrder" => "DESC",
        "includeDetails" => true
      }
    end

    it "executes get_orders request" do
      stub_vendor_direct_fulfillment_orders_v20211228_get_orders
      response = vendor_direct_fulfillment_orders_client.get_orders(created_after, created_before, params)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)).to include(
        "pagination" => {
          "nextToken" => be_present
        },
        "orders" => be_present
      )
    end
  end

  describe "get_order" do
    let(:purchase_order_number) { "2JK3S9VC" }

    it "executes get_order request" do
      stub_vendor_direct_fulfillment_orders_v20211228_get_order
      response = vendor_direct_fulfillment_orders_client.get_order(purchase_order_number)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)).to include(
        "purchaseOrderNumber" => purchase_order_number,
        "orderDetails" => be_present
      )
    end
  end

  describe "submit_acknowledgement" do
    let(:order_acknowledgements) do
      [
        {
          "purchaseOrderNumber" => "2JK3S9VC",
          "vendorOrderNumber" => "ABC",
          "acknowledgementDate" => "2020-02-20T19:17:34.304Z",
          "acknowledgementStatus" => {
            "code" => "00",
            "description" => "Shipping 100 percent of ordered product"
          },
          "sellingParty" => {
            "partyId" => "999US"
          },
          "shipFromParty" => {
            "partyId" => "ABCD"
          },
          "itemAcknowledgements" => [
            {
              "itemSequenceNumber" => "00001",
              "buyerProductIdentifier" => "B07DFVDRAB",
              "vendorProductIdentifier" => "8806098286500",
              "acknowledgedQuantity" => {
                "amount" => 1,
                "unitOfMeasure" => "Each"
              }
            }
          ]
        }
      ]
    end
    let(:transaction_id) { "20190827182357-8725bde9-c61c-49f9-86ac-46efd82d4da5" }

    it "executes submit_acknowledgement request" do
      stub_vendor_direct_fulfillment_orders_v20211228_submit_acknowledgement
      response = vendor_direct_fulfillment_orders_client.submit_acknowledgement(order_acknowledgements)
      expect(response.response_code).to eq(202)
      expect(JSON.parse(response.body)["transactionId"]).to eq transaction_id
    end
  end
end
