module MuffinMan
  module Helpers
    module Fees 
    	class MoneyType
        USD = 'USD'.freeze
        EUR = 'EUR'.freeze
        GBP = 'GBP'.freeze
        RMB = 'RMB'.freeze
        INR = 'INR'.freeze
        JPY = 'JPY'.freeze
        CAD = 'CAD'.freeze
        MXN = 'MXN'.freeze

        attr_accessor :currency_code 
        attr_accessor :amount

        def initialize(amount,currency_code)
          @currency_code = currency_code
          @amount = amount
        end
      end
    end
  end
end
