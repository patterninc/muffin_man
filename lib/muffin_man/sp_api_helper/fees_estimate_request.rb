# frozen_string_literal: true

require "muffin_man/sp_api_helper/price_to_estimate_fees"

module SpApiHelper
  class FeesEstimateRequest
    attr_accessor :marketplace_id, :price_to_estimate_fees, :identifier, :is_amazon_fulfilled,
                  :optional_fulfillment_program

    def initialize(marketplace_id, price, currency_code, shipping, points, identifier, is_amazon_fulfilled,
                   optional_fulfillment_program)
      @marketplace_id = marketplace_id
      @price_to_estimate_fees = PriceToEstimateFees.new(price, currency_code, shipping, points)
      @identifier = identifier
      @is_amazon_fulfilled = is_amazon_fulfilled
      @optional_fulfillment_program = optional_fulfillment_program if is_amazon_fulfilled
    end
  end
end
