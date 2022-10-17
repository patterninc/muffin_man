module MuffinMan
  module Feeds
    require "sp_api_helpers"
    class V20210630 < SpApiClient

      FEED_PATH = "/feeds/2021-06-30"

      def create_feed(feed_type, marketplace_ids, input_feed_document_id, params={})
        @local_var_path = "#{FEED_PATH}/feeds"
        @request_body = {"feedType"=> feed_type, "marketplaceIds"=> marketplace_ids, "inputFeedDocumentId"=> input_feed_document_id}.merge(sp_api_params(params))
        @request_type = "POST"
        call_api
      end

      def get_feeds(params)
        @local_var_path = "#{FEED_PATH}/feeds"
        sp_api_params = sp_api_params(params)
        @query_params = sp_api_params.key?("nextToken") ?  sp_api_params.slice("nextToken") : sp_api_params
        @request_type = "GET"
        call_api
      end

      def get_feed(feed_id)
        @local_var_path = "#{FEED_PATH}/feeds/#{feed_id}"
        @request_type = "GET"
        call_api
      end

      def create_feed_document(content_type, params={})
        @local_var_path = "#{FEED_PATH}/documents"
        @request_body = {"contentType"=> content_type}.merge(sp_api_params(params))
        @request_type = "POST"
        call_api
      end

      def get_feed_document(feed_document_id)
        @local_var_path = "#{FEED_PATH}/documents/#{feed_document_id}"
        @request_type = "GET"
        call_api
      end
    end
  end
end
