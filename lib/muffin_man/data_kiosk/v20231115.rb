# frozen_string_literal: true

module MuffinMan
  module DataKiosk
    class V20231115 < SpApiClient
      SANDBOX_PAGE_SIZE = 1
      SANDBOX_PROCESSING_STATUSES = "DONE, IN_PROGRESS"
      SANDBOX_QUERY = <<-QUERY
      query {
        sampleQuery(
          startDate: "2023-03-01"
          endDate: "2023-03-31"
          marketplaceIds: ["ATVPDKIKX0DER"]
        ) {
          sales {
            date
            averageSellingPrice {
              amount
              currencyCode
            }
          }
        }
      }
      QUERY
      SANDBOX_QUERY_ID = "QueryId1"
      SANDBOX_DOCUMENT_ID = "DocumentId1"

      GET_QUERIES_PARAMS = %w[
        processingStatuses
        pageSize
        createdSince
        createdUntil
        paginationToken
      ].freeze

      def get_queries(params = {})
        @local_var_path = "/dataKiosk/2023-11-15/queries"
        if sandbox
          params = {
            "pageSize" => SANDBOX_PAGE_SIZE,
            "processingStatuses" => SANDBOX_PROCESSING_STATUSES
          }
        end
        @query_params = params.slice(*GET_QUERIES_PARAMS)
        @request_type = "GET"
        call_api
      end

      def create_query(query, pagination_token = nil)
        @local_var_path = "/dataKiosk/2023-11-15/queries"
        query = SANDBOX_QUERY if sandbox
        @request_body = {
          "query" => query
        }
        @request_body["paginationToken"] = pagination_token unless pagination_token.nil?
        @request_type = "POST"
        call_api
      end

      def get_query(query_id)
        query_id = SANDBOX_QUERY_ID if sandbox
        @local_var_path = "/dataKiosk/2023-11-15/queries/#{query_id}"
        @request_type = "GET"
        call_api
      end

      def cancel_query(query_id)
        query_id = SANDBOX_QUERY_ID if sandbox
        @local_var_path = "/dataKiosk/2023-11-15/queries/#{query_id}"
        @request_type = "DELETE"
        call_api
      end

      def get_document(document_id)
        document_id = SANDBOX_DOCUMENT_ID if sandbox
        @local_var_path = "/dataKiosk/2023-11-15/documents/#{document_id}"
        @request_type = "GET"
        call_api
      end

      def retrieve_document_content(document_id)
        response = get_document(document_id)
        if response.success?
          Typhoeus.get(JSON.parse(response.body)["documentUrl"], accept_encoding: "")
        else
          response
        end
      end
    end
  end
end
