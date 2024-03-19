# frozen_string_literal: true

module MuffinMan
  module ProductPricing
    class V0 < SpApiClient
      GET_PRICING_PARAMS = %w[Asins Skus ItemCondition CustomerType].freeze
      GET_COMPETITIVE_PRICE_PARAMS = %w[Asins Skus CustomerType].freeze
      GET_LISTING_OFFERS_PARAMS = %w[CustomerType].freeze
      GET_ITEM_OFFERS_PARAMS = %w[CustomerType].freeze

      def get_pricing(marketplace_id, item_type='Asin', params = {})
        @local_var_path = '/products/pricing/v0/price'
        @params = { 'MarketplaceId' => marketplace_id, 'ItemType' => item_type }
        @params.merge! params.slice(*GET_PRICING_PARAMS)
        @query_params = hash_to_sp_api_uri_params(@params)
        @request_type = "GET"
        call_api
      end

      def get_competitive_pricing(marketplace_id, item_type='Asin', params = {})
        @local_var_path = '/products/pricing/v0/competitivePrice'
        @params = { 'MarketplaceId' => marketplace_id, 'ItemType' => item_type }
        @params.merge! params.slice(*GET_COMPETITIVE_PRICE_PARAMS)
        @query_params = hash_to_sp_api_uri_params(@params)
        @request_type = "GET"
        call_api
      end

      def get_listing_offers(marketplace_id, item_condition, seller_sku, params = {})
        @local_var_path = "/products/pricing/v0/listings/#{seller_sku}/offers"
        @params = { 'MarketplaceId' => marketplace_id, 'ItemCondition ' => item_condition }
        @params.merge! params.slice(*GET_LISTING_OFFERS_PARAMS)
        @query_params = hash_to_sp_api_uri_params(@params)
        @request_type = "GET"
        call_api
      end

      def get_item_offers(marketplace_id, item_condition, asin, params = {})
        @local_var_path = "/products/pricing/v0/items/#{asin}/offers"
        @params = { 'MarketplaceId' => marketplace_id, 'ItemCondition ' => item_condition }
        @params.merge! params.slice(*GET_ITEM_OFFERS_PARAMS)
        @query_params = hash_to_sp_api_uri_params(@params)
        @request_type = "GET"
        call_api
      end

      # params is a hash with the following structure:
      # [
      #   {
      #     "marketplace_id": "marketplace_id1",
      #     "asin": "asin1",
      #     "condition": "New",
      #     "customer_type": "Consumer" # Optional
      # ]
      def get_item_offers_batch(params = {})
        @local_var_path = "/batches/products/pricing/v0/itemOffers"
        requests = []
        params.each do |p|
          request = {
            "uri" => "/products/pricing/v0/items/#{p[:asin]}/offers",
            "method" => "GET",
            "MarketplaceId" => p[:marketplace_id],
            "ItemCondition" => p[:condition]
          }
          request["CustomerType"] = p[:customer_type] if p[:customer_type]
          requests << request
        end
        @request_body = { "requests" => requests }
        @request_type = "POST"
      end

      # params is a hash with the following structure:
      # [
      #   {
      #     "marketplace_id": "marketplace_id1",
      #     "seller_sku": "sku1",
      #     "condition": "New",
      #     "customer_type": "Consumer" # Optional
      # ]
      def get_listing_offers_batch(params = {})
        @local_var_path = "/batches/products/pricing/v0/listingOffers"
        requests = []
        params.each do |p|
          request = {
            "uri" => "/products/pricing/v0/listings/#{p[:seller_sku]}/offers",
            "method" => "GET",
            "MarketplaceId" => p[:marketplace_id],
            "ItemCondition" => p[:condition]
          }
          request["CustomerType"] = p[:customer_type] if p[:customer_type]
          requests << request
        end
        @request_body = { "requests" => requests }
        @request_type = "POST"
      end

      private

      # SP APIs expect param array on the form of Asins=Asin1%2CAsin2 (%2C is url escaped for ,) ...
      def hash_to_sp_api_uri_params(params)
        params.keys.map { |k| "#{k}=#{params[k].is_a?(Array) ? params[k].join("%2C") : params[k]}" }.join('&')
      end
    end
  end
end
