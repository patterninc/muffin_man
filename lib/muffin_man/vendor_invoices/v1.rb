module MuffinMan
  module VendorInvoices
    class V1 < SpApiClient
      def submit_invoices(invoices)
        @local_var_path = "/vendor/payments/v1/invoices"
        @request_body = { "invoices" => invoices }
        @request_type = "POST"
        call_api
      end
    end
  end
end
