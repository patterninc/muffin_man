RSpec.describe MuffinMan::Listings::V20200901 do
  before do
    stub_request_access_token
  end
  
  let(:keyword) { "LUGGAGE" }
  let(:product_type) { "YARN" }
  let(:amazon_marketplace_id) { "DRURYLANE" }
  
  subject(:listings_client) { described_class.new(credentials) }

  describe "search_definitions_product_types" do
    before { stub_search_definitions_product_types }
    it "makes a request to search definitions product types" do
      response = listings_client.search_definitions_product_types(amazon_marketplace_id, keyword)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body).dig("productTypes").first["name"]).to eq(keyword)
    end
  end

  describe "get_definitions_product_type" do
    before { stub_get_definitions_product_type }
    it "makes a request to get definitions product type" do
      options = { requirementsEnforced: "ENFORCED", locale: "en_US" }
      response = listings_client.get_definitions_product_type(product_type, amazon_marketplace_id, options)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body).dig("productType")).to eq(product_type)
    end
  end
end
  