RSpec.describe MuffinMan::CatalogItems::V20220401 do
  before do
    stub_request_access_token
    stub_search_catalog_items_v20220401
    stub_get_catalog_item_v20220401
  end

  let(:keywords) { "stuff" }
  let(:amazon_marketplace_id) { "ATVPDKIKX0DER" }
  let(:asin) { "B000XXXXXX" }

  subject(:catalog_items_client) { described_class.new(credentials) }

  describe "search_catalog_items" do
    it "makes a search_catalog_items request to amazon" do
      response = catalog_items_client.search_catalog_items(keywords, amazon_marketplace_id)
      response_body = JSON.parse(response.body)
      expect(response.response_code).to eq(200)
      expect(response_body.keys).to include("items")
    end
  end

  describe "get_catalog_item" do
    it "makes a get_catalog_item request to amazon" do
      response = catalog_items_client.get_catalog_item(asin, amazon_marketplace_id)
      response_body = JSON.parse(response.body)
      expect(response.response_code).to eq(200)
      expect(response_body["asin"]).to eq(asin)
    end
  end
end
