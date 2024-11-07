module MuffinMan
  module CustomerFeedback ### THIS API IS ONLY IN BETA
    class V20240601 < SpApiClient
      CUSTOMER_FEEDBACK_PATH = "/customerFeedback/2024-06-01"

      def get_item_review_topics(asin, sort_type, marketplace_id, params = {})
          @local_var_path = "#{CUSTOMER_FEEDBACK_PATH}/items/#{asin}/reviews/topics"
          @query_params = {
              "marketplaceId" => marketplace_id, 
              "sortBy" => sort_type                 
              }.merge(params) 
          @request_type = "GET"
          call_api
      end

      def get_item_review_trends(asin, marketplace_id, params = {})
        @local_var_path = "#{CUSTOMER_FEEDBACK_PATH}/items/#{asin}/reviews/trends"
        @query_params = {
            "marketplaceId" => marketplace_id                
            }.merge(params) 
        @request_type = "GET"
        call_api
      end

      def get_browse_node(asin, marketplace_id, params = {})
        @local_var_path = "#{CUSTOMER_FEEDBACK_PATH}/items/#{asin}/browseNode"
        @query_params = {
            "marketplaceId" => marketplace_id                
            }.merge(params) 
        @request_type = "GET"
        call_api
      end

      def get_browse_node_review_topics(browse_node, sort_type, marketplace_id, params = {})
        @local_var_path = "#{CUSTOMER_FEEDBACK_PATH}/browseNodes/#{browse_node}/reviews/topics"
        @query_params = {
          "marketplaceId" => marketplace_id, 
          "sortBy" => sort_type                 
          }.merge(params) 
        @request_type = "GET"
        call_api
      end

      def get_browse_node_review_trends(browse_node, marketplace_id, params = {})
        @local_var_path = "#{CUSTOMER_FEEDBACK_PATH}/browseNodes/#{browse_node}/reviews/trends"
        @query_params = {
            "marketplaceId" => marketplace_id                
            }.merge(params) 
        @request_type = "GET"
        call_api
      end

      def get_browse_node_return_topics(browse_node, sort_type, marketplace_id, params = {})
        @local_var_path = "#{CUSTOMER_FEEDBACK_PATH}/browseNodes/#{browse_node}/returns/topics"
        @query_params = {
          "marketplaceId" => marketplace_id, 
          "sortBy" => sort_type                 
          }.merge(params) 
        @request_type = "GET"
        call_api
      end

      def get_browse_node_return_trends(browse_node, marketplace_id, params = {})
        @local_var_path = "#{CUSTOMER_FEEDBACK_PATH}/browseNodes/#{browse_node}/returns/trends"
        @query_params = {
            "marketplaceId" => marketplace_id                
            }.merge(params) 
        @request_type = "GET"
        call_api
      end
    end
  end
end
