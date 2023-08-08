require "muffin_man/enable_logger"

module MuffinMan
  module Finances
    class V0 < SpApiClient
      include EnableLogger

      def list_financial_event_groups(max_results_per_page = nil, financial_event_group_started_before = nil, financial_event_group_started_after = nil, next_token = nil)
        @local_var_path = "/finances/v0/financialEventGroups"
        @query_params = {}
        @query_params["MaxResultsPerPage"] = max_results_per_page unless max_results_per_page.nil?
        unless financial_event_group_started_before.nil?
          @query_params["FinancialEventGroupStartedBefore"] =
            financial_event_group_started_before
        end
        unless financial_event_group_started_after.nil?
          @query_params["FinancialEventGroupStartedAfter"] =
            financial_event_group_started_after
        end
        @query_params["NextToken"] = next_token unless next_token.nil?
        @request_type = "GET"
        call_api
      end

      def list_financial_events_by_group_id(event_group_id, max_results_per_page = nil, posted_after = nil, posted_before = nil, next_token = nil)
        @local_var_path = "/finances/v0/financialEventGroups/#{event_group_id}/financialEvents"
        @query_params = {}
        @query_params["MaxResultsPerPage"] = max_results_per_page unless max_results_per_page.nil?
        @query_params["PostedAfter"] = posted_after unless posted_after.nil?
        @query_params["PostedBefore"] = posted_before unless posted_before.nil?
        @query_params["NextToken"] = next_token unless next_token.nil?
        @request_type = "GET"
        call_api
      end
    end
  end
end
