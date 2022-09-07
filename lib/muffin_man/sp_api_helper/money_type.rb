# frozen_string_literal: true

module SpApiHelper
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
  end
end
