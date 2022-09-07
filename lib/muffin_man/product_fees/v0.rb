# frozen_string_literal: true

module MuffinMan
  module ProductFees
    require "json"
    class V0 < SpApiClient
      attr_reader :asin
      #TODO: Allow api to send their own identifier
      def get_my_fees_estimate_for_asin(asin, request_body)
        @asin = asin
        @local_var_path = "/products/fees/v0/items/#{@asin}/feesEstimate"
        @request_body = request_body
        @request_type = "POST"
        call_api
      end
    end
  end
end
