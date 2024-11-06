# frozen_string_literal: true
RSpec.describe MuffinMan::CategoryFeedback::V20240601 do
  subject(:customer_feedback_client) { described_class.new(credentials) }

  before do
    stub_request_access_token
  end

  let(:asin) { "B00G5L85S2" }
  let(:sort_type) { "MENTIONS" }
  let(:marketplace_id) { "ATVPDKIKX0DER" }

  describe "get_item_review_topics" do
    before { stub_get_item_review_topics_v20220601 }
    it "makes a request to get_item_review_topics" do
        response = customer_feedback_client.get_item_review_topics(asin, sort_type, marketplace_id)
        expect(response.response_code).to eq(200)
        expect(JSON.parse(response.body)["asin"]).to eq(asin)
    end
  end
end
  