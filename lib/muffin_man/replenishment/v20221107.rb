# frozen_string_literal: true

module MuffinMan
  module Replenishment
    class V20221107 < SpApiClient
      REPLENISHMENT_PATH = "/replenishment/2022-11-07"

      # Returns a selling partner's replenishment offers.
      # `filters` requires `marketplaceId` and `programTypes`.
      # `pagination` is `{ "limit" => Integer, "offset" => Integer }`.
      def list_offers(filters, pagination, sort: nil)
        @local_var_path = "#{REPLENISHMENT_PATH}/offers/search"
        @query_params = {}
        @request_body = {
          "filters" => filters,
          "pagination" => pagination
        }
        @request_body["sort"] = sort if sort
        @request_type = "POST"
        call_api
      end

      # Returns replenishment metrics for each of a selling partner's offers.
      # `filters` requires `marketplaceId`, `programTypes`, `timeInterval`, and `timePeriodType`.
      # `pagination` is `{ "limit" => Integer, "offset" => Integer }`.
      def list_offer_metrics(filters, pagination, sort: nil)
        @local_var_path = "#{REPLENISHMENT_PATH}/offers/metrics/search"
        @query_params = {}
        @request_body = {
          "filters" => filters,
          "pagination" => pagination
        }
        @request_body["sort"] = sort if sort
        @request_type = "POST"
        call_api
      end

      # Returns aggregated replenishment metrics for a selling partner.
      # `time_period_type` is `PERFORMANCE` or `FORECAST`.
      # Optional `filters` narrow by ASIN, SKU, fulfillment channel, brand, or product group.
      def get_selling_partner_metrics(marketplace_id, time_interval, time_period_type, program_types,
                                      aggregation_frequency: nil, metrics: nil, filters: nil)
        @local_var_path = "#{REPLENISHMENT_PATH}/sellingPartners/metrics/search"
        @query_params = {}
        @request_body = {
          "marketplaceId" => marketplace_id,
          "timeInterval" => time_interval,
          "timePeriodType" => time_period_type,
          "programTypes" => program_types
        }
        @request_body["aggregationFrequency"] = aggregation_frequency if aggregation_frequency
        @request_body["metrics"] = metrics if metrics
        @request_body["filters"] = filters if filters
        @request_type = "POST"
        call_api
      end
    end
  end
end
