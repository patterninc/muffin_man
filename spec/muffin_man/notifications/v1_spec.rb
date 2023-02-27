# frozen_string_literal: true

RSpec.describe MuffinMan::Notifications::V1 do
  subject(:notification_client) { described_class.new(credentials) }

  before do
    if self.class.metadata[:uses_grantless]
      stub_request_grantless_access_token
    else
      stub_request_access_token
    end
  end

  let(:scope) { "sellingpartnerapi::notifications" }
  let(:arn) { "arn:aws:sqs:us-east-2:444455556666:queue1" }
  let(:notification_type) { "ANY_OFFER_CHANGED" }
  let(:name) { "Feed process finish notification" }
  let(:destination_id) { "3acafc7e-121b-1329-8ae8-XXXXX" }
  let(:subscription_id) { "7fcacc7e-727b-11e9-8848-1681XXXXX" }

  describe "create_destination", uses_grantless: true do
    it "executes create_destination request" do
      stub_create_destination
      response = notification_client.create_destination(arn, name)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["payload"]["name"]).to eq name
    end
  end

  describe "get_destinations", uses_grantless: true do
    it "executes get_destinations request" do
      stub_get_destinations
      response = notification_client.get_destinations
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)).not_to be_nil
    end
  end

  describe "get_destination", uses_grantless: true do
    it "executes get_destination request" do
      stub_get_destination
      response = notification_client.get_destination(destination_id)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["payload"]["destinationId"]).to eq destination_id
    end
  end

  describe "delete_destination", uses_grantless: true do
    it "executes delete_destination request" do
      stub_delete_destination
      response = notification_client.delete_destination(destination_id)
      expect(response.response_code).to eq(200)
    end
  end

  describe "create_subscription" do
    it "executes create_subscription request" do
      stub_create_subscription
      response = notification_client.create_subscription(notification_type,
                                                         { destination_id: destination_id,
                                                           payload_version: "1.0",
                                                           processing_directive: {
                                                             eventFilter: {
                                                               eventFilterType: "ANY_OFFER_CHANGED",
                                                               marketplaceIds: "ASWDDXDER323",
                                                               aggregationSettings: {
                                                                 aggregationTimePeriod: "FiveMinutes"
                                                               }
                                                             }
                                                           } })
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["payload"].keys).to include("subscriptionId")
    end
  end

  describe "get_subscription" do
    it "executes get_subscription request" do
      stub_get_subscription
      response = notification_client.get_subscription(notification_type)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["payload"].keys).to include("subscriptionId")
    end
  end

  describe "get_subscription_by_id", uses_grantless: true do
    it "executes get_subscription_by_id request" do
      stub_get_subscription_by_id
      response = notification_client.get_subscription_by_id(notification_type, subscription_id)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["payload"]["subscriptionId"]).to eq subscription_id
    end
  end

  describe "delete_subscription_by_id", uses_grantless: true do
    it "executes delete_subscription_by_id request" do
      stub_delete_subscription_by_id
      response = notification_client.delete_subscription_by_id(notification_type, subscription_id)
      expect(response.response_code).to eq(200)
    end
  end
end
