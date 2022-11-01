RSpec.describe MuffinMan::ProductPricing::V0 do
  before do
    stub_request_access_token
    stub_get_competitive_pricing
  end

  let(:amazon_marketplace_id) { "ATVPDKIKX0DER" }
  let(:item_type) { "Asin" }
  let(:asin) { "B09WZ936D8" }

  subject(:product_pricing_client) { described_class.new(credentials) }

  describe "get_competitive_pricing" do
    it "makes a get_competitive_pricing request to amazon" do
      response = product_pricing_client.get_competitive_pricing(amazon_marketplace_id, item_type, { 'Asins' => asin })
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["payload"][0]['status']).to eq("Success")
    end
  end
end
