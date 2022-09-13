# frozen_string_literal: true

# Module to help create request body for API endpoints
module SpApiHelpers
  require "securerandom"

  def self.fees_estimate_request_body(marketplace_id, price, fees_currency_code,
                                      shipping = nil, points = nil, identifier = SecureRandom.uuid,
                                      is_amazon_fulfilled = true, optional_fulfillment_program = "FBA_CORE")
    GetMyFeesEstimateRequest.new(marketplace_id, price, fees_currency_code,
                                 shipping, points, identifier,
                                 is_amazon_fulfilled, optional_fulfillment_program)
  end
  class GetMyFeesEstimateRequest
    attr_accessor :fees_estimate_request

    def initialize(marketplace_id, price, fees_currency_code, shipping, points, identifier,
                   is_amazon_fulfilled, optional_fulfillment_program)
      @fees_estimate_request = FeesEstimateRequest.new(marketplace_id, price, fees_currency_code, shipping, points,
                                                       identifier, is_amazon_fulfilled, optional_fulfillment_program)
    end

    def to_camelize
      {
        "FeesEstimateRequest" =>
          fees_estimate_request.to_camelize
      }
    end
  end

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

    def to_camelize
      {
        "Identifier" => identifier,
        "IsAmazonFulfilled" => is_amazon_fulfilled,
        "MarketplaceId" => marketplace_id,
        "OptionalFulfillmentProgram" => optional_fulfillment_program,
        "PriceToEstimateFees" => price_to_estimate_fees.to_camelize
      }
    end
  end

  class PriceToEstimateFees
    attr_accessor :listing_price, :shipping, :points

    def initialize(listing_price, currency_code = MoneyType::USD, shipping = nil, points = nil)
      @listing_price = MoneyType.new(listing_price, currency_code)
      @shipping = MoneyType.new(shipping, currency_code) if shipping
      @points = points if points
    end

    def to_camelize
      { "ListingPrice" => listing_price.to_camelize }
    end
  end

  class MoneyType
    USD = "USD"
    EUR = "EUR"
    GBP = "GBP"
    RMB = "RMB"
    INR = "INR"
    JPY = "JPY"
    CAD = "CAD"
    MXN = "MXN"

    attr_accessor :amount, :currency_code

    def initialize(amount, currency_code = USD)
      @amount = amount.to_f
      @currency_code = currency_code
    end

    def to_camelize
      {
        "Amount" => amount,
        "CurrencyCode" => currency_code
      }
    end
  end
end
