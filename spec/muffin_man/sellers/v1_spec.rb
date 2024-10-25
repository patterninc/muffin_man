# frozen_string_literal: true

RSpec.describe MuffinMan::Sellers::V1 do
  subject(:sellers_client) { described_class.new(credentials) }

  before do
    stub_request_access_token
  end

  describe "get_account" do
    it "executes `account` request" do
      stub_sellers_account
      response = sellers_client.account
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["business"]["name"]).to eq("BestSeller Inc.")
    end

    it "executes `marketplace_participations` request" do
      response = sellers_client.marketplace_participations
      expect(response.response_code).to eq(200)
    end
  end
end
