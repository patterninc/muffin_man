# frozen_string_literal: true

module MuffinMan
  module VendorDirectFulfillmentTransactions
    class V20211228 < SpApiClient
      def get_transaction_status(transaction_id)
        @local_var_path = "/vendor/directFulfillment/transactions/2021-12-28/transactions/#{transaction_id}"
        @request_type = "GET"
        call_api
      end
    end
  end
end
