# frozen_string_literal: true

module MuffinMan
  module Sellers
    class V1 < SpApiClient
      def account
        @local_var_path = "/sellers/v1/account"
        @request_type = "GET"
        call_api
      end
    end
  end
end
