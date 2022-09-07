# frozen_string_literal: true
require 'muffin_man/sp_api_helper/fees_estimate_request'

module SpApiHelper
  class GetMyFeesEstimateRequest
    attr_accessor :fees_estimate_request

    def initialize(marketplace_id, price, fees_currency_code, shipping, points, identifier,
                   is_amazon_fulfilled, optional_fulfillment_program)
      @fees_estimate_request = FeesEstimateRequest.new(marketplace_id, price, fees_currency_code, shipping, points,
                                                       identifier, is_amazon_fulfilled, optional_fulfillment_program)
    end
  end
end
