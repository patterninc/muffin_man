# frozen_string_literal: true

require 'muffin_man/sp_api_helper/money_type'

module SpApiHelper
  class PriceToEstimateFees
    attr_accessor :listing_price, :shipping, :points

    def initialize(listing_price, currency_code = MoneyType::USD, shipping = nil, points = nil)
      @listing_price = MoneyType.new(listing_price, currency_code)
      @shipping = MoneyType.new(shipping, currency_code) if shipping
      @points = points if points
    end
  end
end
