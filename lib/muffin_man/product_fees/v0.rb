# frozen_string_literal: true

module MuffinMan
  module ProductFees
    require "json"
    require "sp_api_helpers"
    class V0 < SpApiClient
      attr_reader :asin

      def get_my_fees_estimate_for_asin(asin, marketplace_id, map_price, currency_code, shipping = nil, points = nil,
                                        identifier = SecureRandom.uuid, is_amazon_fulfilled = true,
                                        optional_fulfillment_program = "FBA_CORE")
        @local_var_path = "/products/fees/v0/items/#{asin}/feesEstimate"
        @request_body = SpApiHelpers
                        .fees_estimate_request_body(marketplace_id, map_price, currency_code, shipping, points,
                                                    identifier, is_amazon_fulfilled, optional_fulfillment_program)
                        .to_camelize
        @request_type = "POST"
        call_api
      end
    end
  end
end
