RSpec.describe MuffinMan::CatalogItems do
  before do
    stub_request_access_token
    stub_catalog_items
  end
  let(:asin) { "B000XXXXXX" }
  let(:amazon_marketplace_id) { "ATVPDKIKX0DER" }

  subject(:catalog_items_client) { described_class.new(credentials) }

  describe "get_catalog_item" do
    it 'makes a get_catalog_item request to amazon' do
      expect(catalog_items_client.get_catalog_item(asin, amazon_marketplace_id).response_code).to eq(200)
    end
  end
end
