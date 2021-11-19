module MuffinMan
  class Reports < SpApiClient
    SANDBOX_REPORT_TYPE = "GET_MERCHANT_LISTINGS_ALL_DATA"
    SANDBOX_START_TIME = "2019-12-10T20:11:24.000Z"
    SANDBOX_MARKETPLACE_IDS = [
      "A1PA6795UKMFR9",
      "ATVPDKIKX0DER"
    ]

    def create_report(report_type, marketplace_ids, start_time = nil, end_time = nil, report_options = {})
      report_type = sandbox ? SANDBOX_REPORT_TYPE : report_type
      marketplace_ids = sandbox ? SANDBOX_MARKETPLACE_IDS : marketplace_ids
      start_time = sandbox ? SANDBOX_START_TIME : start_time

      @local_var_path = "/reports/2021-06-30/reports"
      @request_body = {
        "reportType" => report_type,
        "marketplaceIds" => marketplace_ids,
      }
      @request_body["dataStartTime"] = start_time unless start_time.nil?
      @request_body["dataEndTime"] = end_time unless end_time.nil?
      @request_body["reportOptions"] = report_options unless report_options.empty?
      @request_type = 'POST'
      call_api
    end
  end
end
