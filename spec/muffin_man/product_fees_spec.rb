RSpec.describe MuffinMan::ProductFees::V0 do
  before do
    stub_request_access_token
    stub_get_my_fees_estimate_for_asin
  end
  let(:asin) { "B09WZ936D8" }
  let(:amazon_marketplace_id) { "ATVPDKIKX0DER" }
  let(:product_map_price) { "149.94" }
  let(:currency_code) { "USD" }
  let(:request_body) {
    {"FeesEstimateRequest"=>{"MarketplaceId"=>"ATVPDKIKX0DER", "PriceToEstimateFees"=>{"ListingPrice"=>{"Amount"=>149.94, "CurrencyCode"=>"USD"}}, "Identifier"=>"cd4c6683-1198-4a1b-8495-6b6f3e9550b3", "IsAmazonFulfilled"=>true, "OptionalFulfillmentProgram"=>"FBA_CORE"}}
  }
  subject(:product_fees_client) { described_class.new(credentials) }

  describe "get_get_my_fees_estimate_for_asin" do
    it "requests a report" do
      response = product_fees_client.get_my_fees_estimate_for_asin(asin, request_body)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["payload"]["FeesEstimateResult"]["Status"]).to eq("Success")
    end
  end
end
