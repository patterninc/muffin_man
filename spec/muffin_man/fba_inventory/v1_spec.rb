RSpec.describe MuffinMan::FbaInventory::V1 do
  before do
    stub_request_access_token
  end

  subject(:fba_inventory_client) { described_class.new(credentials) }

  describe "get_inventory_summaries" do
    before { stub_get_inventory_summaries_v1 }
    let(:granularity_type) { "Marketplace" }
    let(:granularity_id) { "ATVPDKIKX0DER" }
    let(:marketplace_ids) { "ATVPDKIKX0DER" }
    let(:params) do
      {
        "granularityType" => granularity_type,
        "granularityId" => granularity_id,
        "marketplaceIds" => marketplace_ids
      }
    end

    it 'gets the item eligibility preview' do
      response = fba_inventory_client.get_inventory_summaries(params)
      expect(response.success?).to be true
      expect(JSON.parse(response.body).dig("payload", "inventorySummaries").length).to be > 0
    end
  end
end
