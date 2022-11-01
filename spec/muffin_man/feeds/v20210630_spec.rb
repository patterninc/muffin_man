# frozen_string_literal: true

RSpec.describe MuffinMan::Feeds::V20210630 do
  subject(:feeds_client) { described_class.new(credentials) }

  before do
    stub_request_access_token
  end

  let(:amazon_marketplace_ids) { "ATVPDKIKX0RRR" }
  let(:feed_types) { "POST_FBA_INBOUND_CARTON_CONTENTS" }
  let(:next_token) { "ffeefefd_ccc_fake_token" }
  let(:feed_id) { "5180510XXXX" }
  let(:feed_document_id) { "amzn1.tortuga.4.na.000000-0000-40nn-ae20-c521307857c2.TR82IOYXXXXXX" }
  let(:content_type) { "text/xml" }

  describe "get_feeds" do
    context "without next token" do
      it "executes get_feeds request" do
        stub_get_feeds
        response = feeds_client.get_feeds(feed_types: feed_types, marketplace_ids: amazon_marketplace_ids)
        expect(response.response_code).to eq(200)
        expect(JSON.parse(response.body)["feeds"]).not_to be_nil
      end
    end

    context "with next token" do
      it "executes get_feeds request" do
        stub_next_token_get_feeds
        response = feeds_client.get_feeds(eed_types: feed_types, marketplace_ids: amazon_marketplace_ids,
                                          next_token: next_token)
        expect(response.response_code).to eq(200)
        expect(JSON.parse(response.body)["feeds"]).not_to be_nil
      end
    end
  end

  describe "get_feed" do
    it "executes get_feed request" do
      stub_get_feed
      response = feeds_client.get_feed(feed_id)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["feedId"]).to eq feed_id
    end
  end

  describe "create_feed" do
    it "executes create_feed request" do
      stub_create_feed
      response = feeds_client.create_feed(feed_types, amazon_marketplace_ids, feed_document_id)
      expect(response.response_code).to eq(202)
      expect(JSON.parse(response.body)["feedId"]).to eq feed_id
    end
  end

  describe "create_feed_document" do
    it "executes create_feed_document request" do
      stub_create_feed_document
      response = feeds_client.create_feed_document(content_type)
      expect(response.response_code).to eq(201)
      expect(JSON.parse(response.body).keys).to include("feedDocumentId")
    end
  end

  describe "get_feed_document" do
    it "executes get_feed_document request" do
      stub_get_feed_document
      response = feeds_client.get_feed_document(feed_document_id)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["feedDocumentId"]).to eq feed_document_id
    end
  end
end
