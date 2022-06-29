module MuffinMan
  module Reports
    class V20210630 < SpApiClient
      SANDBOX_REPORT_TYPES = "FEE_DISCOUNTS_REPORT,GET_AFN_INVENTORY_DATA".freeze
      SANDBOX_PROCESSING_STATUSES = "IN_QUEUE,IN_PROGRESS".freeze
      SANDBOX_REPORT_TYPE = "GET_MERCHANT_LISTINGS_ALL_DATA".freeze
      SANDBOX_START_TIME = "2019-12-10T20:11:24.000Z".freeze
      SANDBOX_CANCEL_REPORT_ID = "ID".freeze
      SANDBOX_MARKETPLACE_IDS = %w[
        A1PA6795UKMFR9
        ATVPDKIKX0DER
      ].freeze
      SANDBOX_REPORT_ID = "ID323".freeze
      SANDBOX_REPORT_DOCUMENT_ID = "0356cf79-b8b0-4226-b4b9-0ee058ea5760".freeze

      GET_REPORTS_PARAMS = %w[
        reportTypes
        processingStatuses
        marketplaceIds
        pageSize
        createdSince
        createdUntil
        nextToken
      ].freeze

      def get_reports(params = {})
        @local_var_path = "/reports/2021-06-30/reports"
        if sandbox
          params = {
            "reportTypes" => SANDBOX_REPORT_TYPES,
            "processingStatuses" => SANDBOX_PROCESSING_STATUSES
          }
        end
        @query_params = params.slice(*GET_REPORTS_PARAMS)
        @request_type = "GET"
        call_api
      end

      def create_report(report_type, marketplace_ids, start_time = nil, end_time = nil, report_options = {})
        report_type = sandbox ? SANDBOX_REPORT_TYPE : report_type
        marketplace_ids = sandbox ? SANDBOX_MARKETPLACE_IDS : marketplace_ids
        start_time = sandbox ? SANDBOX_START_TIME : start_time

        @local_var_path = "/reports/2021-06-30/reports"
        @request_body = {
          "reportType" => report_type,
          "marketplaceIds" => marketplace_ids
        }
        @request_body["dataStartTime"] = start_time unless start_time.nil?
        @request_body["dataEndTime"] = end_time unless end_time.nil?
        @request_body["reportOptions"] = report_options unless report_options.empty?
        @request_type = "POST"
        call_api
      end

      def get_report(report_id)
        report_id = sandbox ? SANDBOX_REPORT_ID : report_id
        @local_var_path = "/reports/2021-06-30/reports/#{report_id}"
        @request_type = "GET"
        call_api
      end

      def cancel_report(report_id)
        report_id = sandbox ? SANDBOX_CANCEL_REPORT_ID : report_id
        @local_var_path = "/reports/2021-06-30/reports/#{report_id}"
        @request_type = "DELETE"
        call_api
      end

      def get_report_document(report_document_id)
        report_document_id = sandbox ? SANDBOX_REPORT_DOCUMENT_ID : report_document_id
        @local_var_path = "/reports/2021-06-30/documents/#{report_document_id}"
        @request_type = "GET"
        response = call_api
        parsed_response=JSON.parse(response.body)
        report=Net::HTTP.get(URI.parse(parsed_response['url']))
        unless (parsed_response['compressionAlgorithm']).nil?
          input = StringIO.new(report)
          report = Zlib::GzipReader.new(input).read
        end
        report
      end
    end
  end
end
