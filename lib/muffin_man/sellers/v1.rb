# frozen_string_literal: true

module MuffinMan
  module Sellers
    class V1 < SpApiClient
      # This is only available in the EU region.
      def account
        @local_var_path = "/sellers/v1/account"
        @request_type = "GET"
        call_api
      end

      def marketplace_participations
        @local_var_path = "/sellers/v1/marketplaceParticipations"
        @request_type = "GET"
        call_api
      end
    end
  end
end
