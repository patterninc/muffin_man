RSpec.describe MuffinMan::CatalogItems::V20201201 do
  before do
    stub_request_access_token
    stub_search_catalog_items
    stub_get_catalog_item
  end

  let(:keywords) { "stuff" }
  let(:amazon_marketplace_id) { "ATVPDKIKX0DER" }
  let(:asin) { "B000XXXXXX" }

  subject(:catalog_items_client) { described_class.new(credentials) }

  describe "search_catalog_items" do
    it "makes a search_catalog_items request to amazon" do
      expect(catalog_items_client.search_catalog_items(keywords, amazon_marketplace_id).response_code).to eq(200)
    end
  end

  describe "get_catalog_item" do
    it "makes a get_catalog_item request to amazon" do
      expect(catalog_items_client.get_catalog_item(asin, amazon_marketplace_id).response_code).to eq(200)
    end
  end
end
