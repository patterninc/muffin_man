require 'muffin_man/helpers/fees/fees_estimate_request'

module MuffinMan
  module Helpers
    module Fees 
    	class FeesEstimateByIdRequest
        attr_accessor :id_type
        attr_accessor :id_value
        attr_accessor :fees_estimate_request

        def initialize(id_type, id_value, marketplace_id, price, currency_code, identifier, is_amazon_fulfilled, optional_fullfillment_program=nil, shipping=nil, points=nil)
          @id_type = id_type
          @id_value = id_value
          @fees_estimate_request = Helpers::Fees::FeesEstimateRequest.new(marketplace_id, price, currency_code, identifier, is_amazon_fulfilled, optional_fullfillment_program, shipping, points)
        end

        def to_camelize
          {
            "IdType": id_type,
            "IdValue": id_value,
            "FeesEstimateRequest": fees_estimate_request.to_camelize
          }
        end
      end
    end
  end
end