RSpec.describe MuffinMan::ProductFees::V0 do
  before do
    stub_request_access_token
    stub_get_my_fees_estimate_for_sku
    stub_get_my_fees_estimate_for_asin
    stub_get_my_fees_estimates
  end

  let(:amazon_marketplace_id) { "ATVP000000000" }
  let(:asin) { "ASINXXXXXX" }
  let(:sku) { "SKUXXXXXXX" }

  let(:fees_estimate_request) {
  	MuffinMan::Helpers::Fees::FeesEstimateRequest.new('ATVP000000000',1,'USD', 1, true)
  }
  let(:fees_estimate_by_id_request) {
  	MuffinMan::Helpers::Fees::FeesEstimateByIdRequest.new('ASIN','B000000000','ATVP000000000',1,'USD', 1, true)
  }

  subject(:product_fees_client) { described_class.new(credentials) }


  describe "get_my_fees_estimate_for_asin" do
    it "makes a get_my_fees_estimate_for_asin request to amazon" do
      expect(product_fees_client.get_my_fees_estimate_for_asin(asin, fees_estimate_request).response_code).to eq(200)
    end
  end

  describe "get_my_fees_estimate_for_sku" do
    it "makes a get_my_fees_estimate_for_sku request to amazon" do
      expect(product_fees_client.get_my_fees_estimate_for_sku(sku, fees_estimate_request).response_code).to eq(200)
    end
  end

  describe "get_my_fees_estimates" do
    it "makes a get_my_fees_estimates request to amazon" do
      expect(product_fees_client.get_my_fees_estimates(fees_estimate_by_id_request).response_code).to eq(200)
    end
  end


end