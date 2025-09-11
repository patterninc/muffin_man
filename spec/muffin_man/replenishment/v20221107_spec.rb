# frozen_string_literal: true

RSpec.describe MuffinMan::Replenishment::V20221107 do
  subject(:replenishment_client) { described_class.new(credentials) }
  let(:marketplace_ids) { ["ATVPDKIKX0DER"] }

  before do
    stub_request_access_token
  end

  describe "#list_offers" do
    it "makes a successful request with marketplace IDs only" do
      stub_replenishment_list_offers
      response = replenishment_client.list_offers(marketplace_ids)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["offers"]).to be_an(Array)
    end

    it "makes a successful request with filters" do
      params = {
        "filters" => {
          "enabledOnly" => true,
          "asins" => ["B001234567"]
        }
      }
      stub_replenishment_list_offers_with_filters
      response = replenishment_client.list_offers(marketplace_ids, params)
      expect(response.response_code).to eq(200)
    end

    it "accepts single marketplace ID" do
      stub_replenishment_list_offers
      response = replenishment_client.list_offers("ATVPDKIKX0DER")
      expect(response.response_code).to eq(200)
    end
  end

  describe "#list_offer_metrics" do
    it "makes a successful request for offer metrics" do
      params = {
        "filters" => {
          "timeInterval" => {
            "startDate" => "2023-01-01T00:00:00Z",
            "endDate" => "2023-01-31T23:59:59Z"
          },
          "aggregationFrequency" => "MONTHLY"
        }
      }
      stub_replenishment_list_offer_metrics
      response = replenishment_client.list_offer_metrics(marketplace_ids, params)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["offerMetrics"]).to be_an(Array)
    end

    it "makes a successful request with forecast metrics" do
      params = {
        "filters" => {
          "timeInterval" => {
            "startDate" => "2023-02-01T00:00:00Z",
            "endDate" => "2023-04-30T23:59:59Z"
          },
          "timePeriodType" => "FORECAST",
          "aggregationFrequency" => "MONTHLY"
        }
      }
      stub_replenishment_list_offer_metrics_forecast
      response = replenishment_client.list_offer_metrics(marketplace_ids, params)
      expect(response.response_code).to eq(200)
    end
  end

  describe "#get_selling_partner_metrics" do
    it "makes a successful request for all metrics" do
      params = {
        "filters" => {
          "timeInterval" => {
            "startDate" => "2023-01-01T00:00:00Z",
            "endDate" => "2023-01-31T23:59:59Z"
          },
          "aggregationFrequency" => "MONTHLY"
        }
      }
      stub_replenishment_get_selling_partner_metrics
      response = replenishment_client.get_selling_partner_metrics(marketplace_ids, params)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["aggregatedMetrics"]).to be_an(Array)
    end

    it "makes a successful request with specific metrics" do
      params = {
        "filters" => {
          "timeInterval" => {
            "startDate" => "2023-01-01T00:00:00Z",
            "endDate" => "2023-01-31T23:59:59Z"
          },
          "aggregationFrequency" => "MONTHLY",
          "metrics" => ["SHIPPED_SUBSCRIPTION_UNITS", "TOTAL_SUBSCRIPTIONS_REVENUE"]
        }
      }
      stub_replenishment_get_selling_partner_metrics_specific
      response = replenishment_client.get_selling_partner_metrics(marketplace_ids, params)
      expect(response.response_code).to eq(200)
    end

    it "makes a successful request with forecast metrics" do
      params = {
        "filters" => {
          "timeInterval" => {
            "startDate" => "2023-02-01T00:00:00Z",
            "endDate" => "2023-04-30T23:59:59Z"
          },
          "timePeriodType" => "FORECAST",
          "aggregationFrequency" => "MONTHLY"
        }
      }
      stub_replenishment_get_selling_partner_metrics_forecast
      response = replenishment_client.get_selling_partner_metrics(marketplace_ids, params)
      expect(response.response_code).to eq(200)
    end
  end
end
