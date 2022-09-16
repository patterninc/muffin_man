RSpec.describe MuffinMan::Listings::V20210801 do
  before do
    stub_request_access_token
  end

  let(:sku) { "SD-ABC-12345" }
  let(:seller_id) { "THE_MUFFIN_MAN" }
  let(:amazon_marketplace_id) { "DRURYLANE" }

  subject(:listings_client) { described_class.new(credentials) }

  describe "get_listings_item" do
    before { stub_get_listings_item }
    it "makes a request to get a listings item" do
      expect(listings_client.get_listings_item(seller_id, sku, amazon_marketplace_id).response_code).to eq(200)
      expect(JSON.parse(listings_client.get_listings_item(seller_id, sku, amazon_marketplace_id).body).dig("sku")).to eq(sku)
    end
  end
end
