RSpec.describe MuffinMan::VendorDirectFulfillmentInventory::V1 do
  subject(:vendor_direct_fulfillment_inventory_client) { described_class.new(credentials) }

  before do
    stub_request_access_token
  end

  describe "submit_inventory_update" do
    let(:warehouse_id) { "ABCD" }
    let(:selling_party) { { "partyId" => "VENDORID" } }
    let(:is_full_update) { false }
    let(:items) do
      [
        {
          "buyerProductIdentifier" => "ABCD4562",
          "vendorProductIdentifier" => "7Q89K11",
          "availableQuantity" => {
            "amount" => 10,
            "unitOfMeasure" => "Each"
          },
          "isObsolete" => false
        }
      ]
    end
    let(:transaction_id) { "20190905010908-8a3b6901-ef20-412f-9270-21c021796605" }

    it "executes submit_inventory_update request" do
      stub_vendor_direct_fulfillment_inventory_v1_submit_inventory_update
      response = vendor_direct_fulfillment_inventory_client.submit_inventory_update(warehouse_id, selling_party, is_full_update, items)
      expect(response.response_code).to eq(202)
      expect(JSON.parse(response.body)["transactionId"]).to eq transaction_id
    end
  end
end
