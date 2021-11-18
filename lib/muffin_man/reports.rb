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
      @query_params = {
        "marketplaceIds" => marketplace_ids,
        "dataStartTime" => start_time,
        "dataEndTime" => end_time,
        "reportType" => report_type,
        "reportOptions" => report_options,
      }
      @request_type = 'POST'
      call_api
    end
  end
end
