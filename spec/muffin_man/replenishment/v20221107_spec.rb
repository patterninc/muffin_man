# frozen_string_literal: true

RSpec.describe MuffinMan::Replenishment::V20221107 do
  subject(:replenishment_client) { described_class.new(credentials) }

  let(:marketplace_id) { "ATVPDKIKX0DER" }
  let(:program_types) { ["SUBSCRIBE_AND_SAVE"] }
  let(:time_interval) do
    {
      "startDate" => "2022-01-01T00:00:00Z",
      "endDate" => "2022-12-31T00:00:00Z"
    }
  end

  before do
    stub_request_access_token
  end

  describe "#list_offers" do
    let(:pagination) { { "limit" => 25, "offset" => 0 } }
    let(:filters) do
      {
        "marketplaceId" => marketplace_id,
        "programTypes" => program_types
      }
    end

    it "requests offers for a marketplace and program" do
      body = { "filters" => filters, "pagination" => pagination }
      stub_replenishment_search("offers/search", body, "list_offers.json")

      response = replenishment_client.list_offers(filters, pagination)

      expect(response.response_code).to eq(200)
      parsed = JSON.parse(response.body)
      expect(parsed["offers"].first["asin"]).to eq("B07CYBR5GZ")
      expect(parsed["pagination"]["totalResults"]).to eq(2)
    end

    it "sends optional offer filters and sort" do
      filtered = filters.merge(
        "eligibilities" => ["ELIGIBLE"],
        "deliveriesConditions" => ["NEXT_30_DAYS_DELIVERIES_AT_LOW_INVENTORY_RISK"],
        "preferences" => { "autoEnrollment" => ["OPTED_IN"] },
        "promotions" => { "sellingPartnerFundedBaseDiscount" => { "percentage" => [5] } }
      )
      sort = { "order" => "ASC", "key" => "ASIN" }
      body = { "filters" => filtered, "pagination" => pagination, "sort" => sort }
      stub_replenishment_search("offers/search", body, "list_offers.json")

      response = replenishment_client.list_offers(filtered, pagination, sort: sort)

      expect(response.response_code).to eq(200)
    end
  end

  describe "#list_offer_metrics" do
    let(:pagination) { { "limit" => 2, "offset" => 0 } }

    it "requests performance metrics for offers" do
      filters = {
        "aggregationFrequency" => "YEAR",
        "timeInterval" => time_interval,
        "marketplaceId" => marketplace_id,
        "programTypes" => program_types,
        "timePeriodType" => "PERFORMANCE",
        "asins" => ["B07CYBR5GZ", "B07CYJJW8H"]
      }
      sort = { "order" => "ASC", "key" => "TOTAL_SUBSCRIPTIONS_REVENUE" }
      body = { "filters" => filters, "pagination" => pagination, "sort" => sort }
      stub_replenishment_search("offers/metrics/search", body, "list_offer_metrics.json")

      response = replenishment_client.list_offer_metrics(filters, pagination, sort: sort)

      expect(response.response_code).to eq(200)
      parsed = JSON.parse(response.body)
      expect(parsed["offers"].first["totalSubscriptionsRevenue"]).to eq(100.45)
      expect(parsed["pagination"]["totalResults"]).to eq(17)
    end

    it "requests forecast metrics for offers" do
      filters = {
        "timeInterval" => time_interval,
        "marketplaceId" => marketplace_id,
        "programTypes" => program_types,
        "timePeriodType" => "FORECAST",
        "skus" => ["SD-RES-101973"]
      }
      sort = { "order" => "DESC", "key" => "NEXT_30DAYS_SHIPPED_SUBSCRIPTION_UNITS" }
      body = { "filters" => filters, "pagination" => pagination, "sort" => sort }
      stub_replenishment_search("offers/metrics/search", body, "list_offer_metrics_forecast.json")

      response = replenishment_client.list_offer_metrics(filters, pagination, sort: sort)

      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["offers"].first["next30DayShippedSubscriptionUnits"]).to eq(40)
    end
  end

  describe "#get_selling_partner_metrics" do
    it "requests performance metrics for a selling partner" do
      body = {
        "marketplaceId" => marketplace_id,
        "timeInterval" => time_interval,
        "timePeriodType" => "PERFORMANCE",
        "programTypes" => program_types,
        "aggregationFrequency" => "YEAR",
        "metrics" => ["TOTAL_SUBSCRIPTIONS_REVENUE", "REVENUE_PENETRATION"]
      }
      stub_replenishment_search("sellingPartners/metrics/search", body, "get_selling_partner_metrics.json")

      response = replenishment_client.get_selling_partner_metrics(
        marketplace_id,
        time_interval,
        "PERFORMANCE",
        program_types,
        aggregation_frequency: "YEAR",
        metrics: ["TOTAL_SUBSCRIPTIONS_REVENUE", "REVENUE_PENETRATION"]
      )

      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["metrics"].first["totalSubscriptionsRevenue"]).to eq(131_340.24)
    end

    it "requests forecast metrics and offer filters" do
      filters = {
        "asins" => ["B07CYBR5GZ"],
        "skus" => ["SD-RES-101973"],
        "fulfillmentChannelTypes" => ["AMAZON"]
      }
      body = {
        "marketplaceId" => marketplace_id,
        "timeInterval" => time_interval,
        "timePeriodType" => "FORECAST",
        "programTypes" => program_types,
        "metrics" => ["TOTAL_SUBSCRIPTIONS_REVENUE", "SHIPPED_SUBSCRIPTION_UNITS"],
        "filters" => filters
      }
      stub_replenishment_search(
        "sellingPartners/metrics/search",
        body,
        "get_selling_partner_metrics_forecast.json"
      )

      response = replenishment_client.get_selling_partner_metrics(
        marketplace_id,
        time_interval,
        "FORECAST",
        program_types,
        metrics: ["TOTAL_SUBSCRIPTIONS_REVENUE", "SHIPPED_SUBSCRIPTION_UNITS"],
        filters: filters
      )

      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["metrics"].first["shippedSubscriptionUnits"]).to eq(80)
    end
  end
end
