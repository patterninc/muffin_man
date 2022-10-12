RSpec.describe MuffinMan::Notifications::V1 do
  before do
    stub_request_access_token
  end

  let(:arn) { "arn:aws:sqs:us-east-2:444455556666:queue1" }
  let(:notification_type) { "FeedProcessingFinished" }
  let(:name) {"Feed process finish notification"}
  let(:destination_id) {"3acafc7e-121b-1329-8ae8-XXXXX"}
  let(:subscription_id) {"7fcacc7e-727b-11e9-8848-1681XXXXX"}
  # let(:feed_id) { "5180510XXXX"}
  # let(:feed_document_id) {"amzn1.tortuga.4.na.000000-0000-40nn-ae20-c521307857c2.TR82IOYXXXXXX"}
  # let(:content_type) { "text/xml"}
  subject(:notification_client) { described_class.new(credentials) }

  describe "create_destinations" do
    it "executes create_destinations request" do
      stub_create_destinations
      response = notification_client.create_destinations(arn, {name: name})
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["payload"]["name"]).to eq name
    end
  end

  describe "get_destinations" do
    it "executes get_destinations request" do
      stub_get_destinations
      response = notification_client.get_destinations
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)).not_to be_nil
    end 
  end

  describe "get_destination" do
    it "executes get_destination request" do
      stub_get_destination
      response = notification_client.get_destination(destination_id)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["payload"]["destinationId"]).to eq destination_id
    end 
  end

  describe "create_subscriptions" do
    it "executes create_subscriptions request" do
      stub_create_subscriptions
      response = notification_client.create_subscriptions(notification_type, {destination_id: destination_id, payload_version: "1.0", marketplace_ids: "ASWDDXDER323"})
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["payload"].keys).to include("subscriptionId")
    end
  end

  describe "get_subscriptions" do
    it "executes get_subscriptions request" do
      stub_get_subscriptions
      response = notification_client.get_subscriptions(notification_type)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["payload"].keys).to include("subscriptionId")
    end
  end

  describe "get_subscription" do
    it "executes get_subscription request" do
      stub_get_subscription
      response = notification_client.get_subscription(notification_type, subscription_id)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["payload"]["subscriptionId"]).to eq subscription_id
    end
  end

  describe "delete_subscription" do
    it "executes delete_subscription request" do
      stub_delete_subscription
      response = notification_client.delete_subscription(notification_type, subscription_id)
      expect(response.response_code).to eq(200)
    end
  end
end
