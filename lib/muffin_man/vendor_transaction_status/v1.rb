# frozen_string_literal: true

module MuffinMan
  module VendorTransactionStatus
    class V1 < SpApiClient
      def get_transaction(transaction_id)
        @local_var_path = "/vendor/transactions/v1/transactions/#{transaction_id}"
        @request_type = "GET"
        call_api
      end
    end
  end
end
