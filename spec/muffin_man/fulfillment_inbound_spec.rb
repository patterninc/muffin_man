RSpec.describe MuffinMan::FulfillmentInbound::V0 do
  before do
    stub_request_access_token
  end

  let(:country_code) { "US" }
  let(:sku_list) { ["SD-ABC-12345"] }

  subject(:fba_inbound_client) { described_class.new(credentials) }

  describe "get_prep_instructions" do
    before { stub_get_prep_instructions }

    it "makes a request to get a listings item" do
      expect(fba_inbound_client.get_prep_instructions(country_code, seller_sku_list: sku_list).response_code).to eq(200)
      expect(JSON.parse(fba_inbound_client.get_prep_instructions(country_code, seller_sku_list: sku_list).body).dig("payload", "SKUPrepInstructionsList").first["SellerSKU"]).to eq(sku_list.first)
    end
  end
end
