# frozen_string_literal: true

module MuffinMan
  module ProductPricing
    class V0 < SpApiClient
      GET_COMPETITIVE_PRICE_PARAMS = %w[Asins Skus CustomerType].freeze

      def get_competitive_pricing(marketplace_id, item_type='Asin', params = {})
        @local_var_path = '/products/pricing/v0/competitivePrice'
        @params = { 'MarketplaceId' => marketplace_id, 'ItemType' => item_type }
        @params.merge! params.slice(*GET_COMPETITIVE_PRICE_PARAMS)
        @query_params = hash_to_sp_api_uri_params(@params)
        @request_type = "GET"
        call_api
      end

      private

      # SP APIs expect param array on the form of Asins=Asin1%2CAsin2 (%2C is url escaped for ,) ...
      def hash_to_sp_api_uri_params(params)
        params.keys.map { |k| "#{k}=#{params[k].is_a?(Array) ? params[k].join("%2C") : params[k]}" }.join('&')
      end
    end
  end
end
