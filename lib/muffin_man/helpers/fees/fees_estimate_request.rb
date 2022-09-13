require 'muffin_man/helpers/fees/price_to_estimate_fees'

module MuffinMan
  module Helpers
    module Fees 
    	class FeesEstimateRequest
        attr_accessor :marketplace_id 
        attr_accessor :is_amazon_fulfilled
        attr_accessor :identifier
        attr_accessor :price_to_estimate_fees
        attr_accessor :optional_fullfillment_program

        def initialize(marketplace_id, price, currency_code, identifier, is_amazon_fulfilled, optional_fullfillment_program=nil)
          @marketplace_id = marketplace_id
          @identifier = identifier
          @price_to_estimate_fees = Helpers::Fees::PriceToEstimateFees.new(price, currency_code)
          @is_amazon_fulfilled = is_amazon_fulfilled
          @optional_fullfillment_program = optional_fullfillment_program if optional_fullfillment_program
        end

        def to_request_object
          {
            "FeesEstimateRequest": {
              "MarketplaceId": @marketplace_id,
              "IsAmazonFulfilled":  @is_amazon_fulfilled,
              "Identifier": @identifier,
              "PriceToEstimateFees": {
                "ListingPrice": {
                  "CurrencyCode": @price_to_estimate_fees&.listing_price&.currency_code,
                  "Amount": @price_to_estimate_fees&.listing_price&.amount
                }
              }
            }
          }
        end
      end
    end
  end
end
