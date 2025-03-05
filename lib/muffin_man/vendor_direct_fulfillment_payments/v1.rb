# frozen_string_literal: true

module MuffinMan
  module VendorDirectFulfillmentPayments
    class V1 < SpApiClient
      def submit_invoice(invoices)
        @local_var_path = "/vendor/directFulfillment/payments/v1/invoices"
        @request_body = { "invoices" => invoices }
        @request_type = "POST"
        call_api
      end
    end
  end
end
