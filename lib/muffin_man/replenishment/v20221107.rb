# frozen_string_literal: true

module MuffinMan
  module Replenishment
    class V20221107 < SpApiClient
      # Parameters for listOffers operation
      LIST_OFFERS_PARAMS = %w[
        filters
        sort
        pageSize
        nextToken
      ].freeze

      # Parameters for listOfferMetrics operation
      LIST_OFFER_METRICS_PARAMS = %w[
        filters
        sort
        pageSize
        nextToken
      ].freeze

      # Parameters for getSellingPartnerMetrics operation
      GET_SELLING_PARTNER_METRICS_PARAMS = %w[
        filters
        sort
        pageSize
        nextToken
      ].freeze

      # Get all of a selling partner's replenishment offers filtered by specific criteria
      # @param marketplace_ids [Array<String>] A list of marketplace identifiers
      # @param params [Hash] Optional filtering and pagination parameters
      # @return [Typhoeus::Response] API response
      def list_offers(marketplace_ids, params = {})
        @local_var_path = "/replenishment/2022-11-07/offers/search"
        @request_body = build_search_request_body(marketplace_ids, params, LIST_OFFERS_PARAMS)
        @request_type = "POST"
        call_api
      end

      # Get replenishment business metrics for each of a selling partner's offers
      # @param marketplace_ids [Array<String>] A list of marketplace identifiers
      # @param params [Hash] Optional filtering and pagination parameters
      # @return [Typhoeus::Response] API response
      def list_offer_metrics(marketplace_ids, params = {})
        @local_var_path = "/replenishment/2022-11-07/offers/metrics/search"
        @request_body = build_search_request_body(marketplace_ids, params, LIST_OFFER_METRICS_PARAMS)
        @request_type = "POST"
        call_api
      end

      # Get a selling partner's replenishment business metrics
      # @param marketplace_ids [Array<String>] A list of marketplace identifiers
      # @param params [Hash] Optional filtering and pagination parameters
      # @return [Typhoeus::Response] API response
      def get_selling_partner_metrics(marketplace_ids, params = {})
        @local_var_path = "/replenishment/2022-11-07/sellingPartners/metrics/search"
        @request_body = build_search_request_body(marketplace_ids, params, GET_SELLING_PARTNER_METRICS_PARAMS)
        @request_type = "POST"
        call_api
      end

      private

      # Build request body for search operations
      # @param marketplace_ids [Array<String>] A list of marketplace identifiers
      # @param params [Hash] Parameters containing filters and other options
      # @param allowed_params [Array<String>] List of allowed parameters for this operation
      # @return [Hash] Request body
      def build_search_request_body(marketplace_ids, params, allowed_params)
        marketplace_ids = Array(marketplace_ids)

        request_body = {
          "marketplaceIds" => marketplace_ids
        }

        # Add allowed parameters from params
        allowed_params.each do |param|
          request_body[param] = params[param] if params.key?(param)
        end

        request_body
      end
    end
  end
end
