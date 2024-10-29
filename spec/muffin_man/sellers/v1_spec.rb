# frozen_string_literal: true

RSpec.describe MuffinMan::Sellers::V1 do
  subject(:sellers_client) { described_class.new(credentials) }

  before do
    stub_request_access_token
  end

  describe "Get marketplace participations" do
    it "executes `marketplace_participations` request" do
      stub_sellers_marketplace_participations
      response = sellers_client.marketplace_participations
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["payload"][0]["marketplace"]["name"]).to eq("Amazon.com.mx")
    end
  end
end
