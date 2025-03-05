# frozen_string_literal: true

RSpec.describe MuffinMan::Finances::V20240619 do
  subject(:client) { described_class.new(credentials) }

  let(:posted_after) { "2024-11-07T00:00:00Z" }

  before do
    stub_request_access_token
  end

  describe "list_transactions" do
    before do
      stub_list_financial_transactions(posted_after: posted_after)
    end

    it "lists transactions" do
      response = client.list_transactions(posted_after: posted_after)
      expect(response.success?).to be true
      expect(JSON.parse(response.body)["payload"]["transactions"]).to be_an(Array)
    end
  end
end
