require "securerandom"
require 'muffin_man/sp_api_helper/get_my_fees_estimate_request'

module SpApiHelper
  def self.fees_estimate_request_body(marketplace_id, price, fees_currency_code, shipping = nil, points = nil, identifier = SecureRandom.uuid, is_amazon_fulfilled = true, optional_fulfillment_program = "FBA_CORE")
    GetMyFeesEstimateRequest.new(marketplace_id, price, fees_currency_code, shipping, points, identifier,
                                is_amazon_fulfilled, optional_fulfillment_program)
  end
end
