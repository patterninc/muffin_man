RSpec.describe MuffinMan::FulfillmentInbound::V1 do
  before do
    stub_request_access_token
  end

  subject(:fba_inbound_client) { described_class.new(credentials) }

  describe "get_item_eligibility_preview" do
    before { stub_get_item_eligibility_preview }
    let(:asin) { "B01234567" }
    let(:program) { "COMMINGLING" }

    it 'gets the item eligibility preview' do
      response = fba_inbound_client.get_item_eligibility_preview(asin, program)
      expect(response.success?).to be true
      expect(JSON.parse(response.body).dig("payload", "isEligibleForProgram")).to be true
    end
  end
end
