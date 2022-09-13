require 'muffin_man/helpers/fees/money_type'

module MuffinMan
  module Helpers
    module Fees 
      class PriceToEstimateFees
        attr_accessor :listing_price 
        attr_accessor :shipping
        attr_accessor :points
        
        def initialize(listing_price,currency_code= Helpers::Fees::MoneyType::USD, shipping=nil, points=nil)
          @listing_price = Helpers::Fees::MoneyType.new(listing_price, currency_code)
          @shipping = Helpers::Fees::MoneyType.new(shipping, currency_code) if shipping
          @points = points if points
        end
      end
    end
  end
end
