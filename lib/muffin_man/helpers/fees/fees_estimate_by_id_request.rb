require 'muffin_man/helpers/fees/fees_estimate_request'

module MuffinMan
  module Helpers
    module Fees 
    	class FeesEstimateByIdRequest
        attr_accessor :id_type
        attr_accessor :id_value
        attr_accessor :fees_estimate_request

        def initialize(id_type, id_value, marketplace_id, price, currency_code, identifier, is_amazon_fulfilled)
          @id_type = id_type
          @id_value = id_value
          @fees_estimate_request = Helpers::Fees::FeesEstimateRequest.new(marketplace_id, price, currency_code, identifier, is_amazon_fulfilled)
        end

        def to_request_object
          {
            "IdType": @id_type,
            "IdValue": @id_value,
            "FeesEstimateRequest": {
              "MarketplaceId": @fees_estimate_request.marketplace_id,
              "IsAmazonFulfilled":  @fees_estimate_request&.is_amazon_fulfilled,
              "Identifier": @fees_estimate_request&.identifier,
              "PriceToEstimateFees": {
                "ListingPrice": {
                  "CurrencyCode": @fees_estimate_request&.price_to_estimate_fees&.listing_price&.currency_code,
                  "Amount": @fees_estimate_request&.price_to_estimate_fees&.listing_price&.amount
                }
              }
            }
          }
        end
      end
    end
  end
end