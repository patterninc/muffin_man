# frozen_string_literal: true

RSpec.describe MuffinMan::VendorDirectFulfillmentShipping::V20211228 do
  subject(:vendor_direct_fulfillment_shipping_client) { described_class.new(credentials) }

  let(:created_after) { "2020-02-15T14:00:00-08:00" }
  let(:created_before) { "2020-02-20T00:00:00-08:00" }
  let(:params) do
    {
      "limit" => 2,
      "sortOrder" => "DESC"
    }
  end
  let(:purchase_order_number) { "2JK3S9VC" }
  let(:transaction_id) { "20190905010908-8a3b6901-ef20-412f-9270-21c021796605" }

  before do
    stub_request_access_token
  end

  describe "get_shipping_labels" do
    it "executes get_shipping_labels request" do
      stub_vendor_direct_fulfillment_shipping_v20211228_get_shipping_labels
      response = vendor_direct_fulfillment_shipping_client.get_shipping_labels(created_after, created_before, params)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)).to include(
        "pagination" => {
          "nextToken" => be_present
        },
        "shippingLabels" => be_present
      )
    end
  end

  describe "submit_shipping_label_request" do
    let(:shipping_label_requests) do
      [
        {
          "purchaseOrderNumber" => "2JK3S9VC",
          "sellingParty" => {
            "partyId" => "999US"
          },
          "shipFromParty" => {
            "partyId" => "ABCD"
          },
          "containers" => [
            {
              "containerType" => "carton",
              "containerIdentifier" => "123",
              "weight" => {
                "unitOfMeasure" => "KG",
                "value" => "10"
              },
              "packedItems" => [
                {
                  "itemSequenceNumber" => 1,
                  "packedQuantity" => {
                    "amount" => 1,
                    "unitOfMeasure" => "Each"
                  }
                }
              ]
            }
          ]
        }
      ]
    end

    it "executes submit_shipping_label_request request" do
      stub_vendor_direct_fulfillment_shipping_v20211228_submit_shipping_label_request
      response = vendor_direct_fulfillment_shipping_client.submit_shipping_label_request(shipping_label_requests)
      expect(response.response_code).to eq(202)
      expect(JSON.parse(response.body)["transactionId"]).to eq transaction_id
    end
  end

  describe "get_shipping_label" do
    it "executes get_shipping_label request" do
      stub_vendor_direct_fulfillment_shipping_v20211228_get_shipping_label
      response = vendor_direct_fulfillment_shipping_client.get_shipping_label(purchase_order_number)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)).to include(
        "purchaseOrderNumber" => purchase_order_number,
        "sellingParty" => be_present,
        "shipFromParty" => be_present,
        "labelFormat" => be_present,
        "labelData" => be_present
      )
    end
  end

  describe "create_shipping_labels" do
    let(:selling_party) { { "partyId" => "999US" } }
    let(:ship_from_party) { { "partyId" => "ABCD" } }

    it "executes create_shipping_labels request" do
      stub_vendor_direct_fulfillment_shipping_v20211228_create_shipping_labels
      response = vendor_direct_fulfillment_shipping_client.create_shipping_labels(
        purchase_order_number,
        selling_party,
        ship_from_party,
        []
      )
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)).to include(
        "purchaseOrderNumber" => purchase_order_number,
        "sellingParty" => selling_party,
        "shipFromParty" => ship_from_party,
        "labelFormat" => be_present,
        "labelData" => be_present
      )
    end
  end

  describe "submit_shipment_confirmations" do
    let(:shipment_confirmations) do
      [
        {
          "purchaseOrderNumber" => "PO00050003",
          "shipmentDetails" => {
            "shippedDate" => "2019-08-07T19:56:45.632Z",
            "shipmentStatus" => "SHIPPED"
          },
          "sellingParty" => {
            "partyId" => "VENDORCODE"
          },
          "shipFromParty" => {
            "partyId" => "VENDORWAREHOUSECODE"
          },
          "items" => [
            {
              "itemSequenceNumber" => 1,
              "shippedQuantity" => {
                "amount" => 100,
                "unitOfMeasure" => "Each"
              }
            }
          ]
        }
      ]
    end

    it "executes submit_shipment_confirmations request" do
      stub_vendor_direct_fulfillment_shipping_v20211228_submit_shipment_confirmations
      response = vendor_direct_fulfillment_shipping_client.submit_shipment_confirmations(shipment_confirmations)
      expect(response.response_code).to eq(202)
      expect(JSON.parse(response.body)["transactionId"]).to eq transaction_id
    end
  end

  describe "submit_shipment_status_updates" do
    let(:shipment_status_updates) do
      [
        {
          "purchaseOrderNumber" => "DX00050015",
          "sellingParty" => {
            "partyId" => "999US"
          },
          "shipFromParty" => {
            "partyId" => "ABCD"
          },
          "statusUpdateDetails" => {
            "trackingNumber" => "TRACK005",
            "statusDateTime" => "2020-08-07T19:56:45Z",
            "statusCode" => "D1",
            "reasonCode" => "NS",
            "statusLocationAddress" => {
              "name" => "ABC",
              "addressLine1" => "1st street",
              "countryCode" => "US"
            }
          }
        }
      ]
    end

    it "executes submit_shipment_status_updates request" do
      stub_vendor_direct_fulfillment_shipping_v20211228_submit_shipment_status_updates
      response = vendor_direct_fulfillment_shipping_client.submit_shipment_status_updates(shipment_status_updates)
      expect(response.response_code).to eq(202)
      expect(JSON.parse(response.body)["transactionId"]).to eq transaction_id
    end
  end

  describe "get_customer_invoices" do
    it "executes get_customer_invoices request" do
      stub_vendor_direct_fulfillment_shipping_v20211228_get_customer_invoices
      response = vendor_direct_fulfillment_shipping_client.get_customer_invoices(
        created_after,
        created_before,
        params
      )
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)).to include(
        "pagination" => {
          "nextToken" => be_present
        },
        "customerInvoices" => be_present
      )
    end
  end

  describe "get_customer_invoice" do
    it "executes get_customer_invoice request" do
      stub_vendor_direct_fulfillment_shipping_v20211228_get_customer_invoice
      response = vendor_direct_fulfillment_shipping_client.get_customer_invoice(purchase_order_number)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)).to include(
        "purchaseOrderNumber" => purchase_order_number,
        "content" => be_present
      )
    end
  end

  describe "get_packing_slips" do
    it "executes get_packing_slips request" do
      stub_vendor_direct_fulfillment_shipping_v20211228_get_packing_slips
      response = vendor_direct_fulfillment_shipping_client.get_packing_slips(created_after, created_before, params)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)).to include(
        "pagination" => {
          "nextToken" => be_present
        },
        "packingSlips" => be_present
      )
    end
  end

  describe "get_packing_slip" do
    it "executes get_packing_slip request" do
      stub_vendor_direct_fulfillment_shipping_v20211228_get_packing_slip
      response = vendor_direct_fulfillment_shipping_client.get_packing_slip(purchase_order_number)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)).to include(
        "purchaseOrderNumber" => purchase_order_number,
        "content" => be_present
      )
    end
  end
end
