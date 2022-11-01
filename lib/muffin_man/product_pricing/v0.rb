# frozen_string_literal: true

module MuffinMan
  module ProductPricing
    class V0 < SpApiClient
      GET_COMPETITIVE_PRICE_PARAMS = %w[Asins Skus CustomerType].freeze

      def get_competitive_pricing(marketplace_id, item_type = "Asin", params = {})
        @params = params
        @local_var_path = "/products/pricing/v0/competitivePrice"
        @query_params = { "MarketplaceId" => marketplace_id,
                          "ItemType" => item_type }
        @query_params.merge!(@params.slice(*GET_COMPETITIVE_PRICE_PARAMS))
        @request_type = "GET"
        call_api
      end
    end
  end
end
