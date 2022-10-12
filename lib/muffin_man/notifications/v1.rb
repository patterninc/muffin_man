module MuffinMan
  module Notifications
    require "json"
    require "sp_api_helpers"
    class V1 < SpApiClient

      NOTIFICATION_PATH = "/notifications/v1"

      def create_destinations(arn, params={})
        params = params.transform_keys{|key| key.to_s}
        @local_var_path = "#{NOTIFICATION_PATH}/destinations"
        destination_params = {"resourceSpecification": {"sqs": {"arn": arn}}, "marketplaceIds": params["marketplace_ids"]}
        destination_params.merge!("eventBridge": {"region": params["region"], "accountId": params["account_id"]}) unless params["region"].nil? || params["account_id"].nil?
        destination_params.merge!("name": params["name"]) unless params["name"].nil?
        @request_body = destination_params
        @request_type = "POST"
        call_api
      end

       def get_destinations(params={})
        @local_var_path = "#{NOTIFICATION_PATH}/destinations"
        @query_params = sp_api_params(params)
        @request_type = "GET"
        call_api
      end

      def get_destination(destination_id)
        @local_var_path = "#{NOTIFICATION_PATH}/destinations/#{destination_id}"
        @request_type = "GET"
        call_api
      end

      def create_subscriptions(notification_type, params={})
        params = params.transform_keys{|key| key.to_s}
        @local_var_path = "#{NOTIFICATION_PATH}/subscriptions/#{notification_type}"
        subscription_params = {"destinationId": params["destination_id"], "processingDirective": {"eventFilter": {"eventFilterType": notification_type, "marketplaceIds": params["marketplace_ids"]}}}
        subscription_params.merge!("payloadVersion": params["payload_version"]) unless params["payload_version"].nil?
        @request_body = subscription_params
        @request_type = "POST"
        call_api
      end

      def get_subscriptions(notification_type, params={})
        @local_var_path = "#{NOTIFICATION_PATH}/subscriptions/#{notification_type}"
        @query_params = sp_api_params(params)
        @request_type = "GET"
        call_api
      end

      def get_subscription(notification_type, subscription_id)
        @local_var_path = "#{NOTIFICATION_PATH}/subscriptions/#{notification_type}/#{subscription_id}"
        @request_type = "GET"
        call_api
      end

      def delete_subscription(notification_type, subscription_id)
        @local_var_path = "#{NOTIFICATION_PATH}/subscriptions/#{notification_type}/#{subscription_id}"
        @request_type = "DELETE"
        call_api
      end
    end
  end
end
