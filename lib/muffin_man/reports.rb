module MuffinMan
  class Reports < SpApiClient
    def create_report(report_type, marketplace_ids, start_time = nil, end_time = nil, report_options = {})
      report_type = sandbox ? nil : report_type
      marketplace_ids = sandbox ? nil : marketplace_ids

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
