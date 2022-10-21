# frozen_string_literal: true

module MuffinMan
  module Notifications
    require "json"
    require "sp_api_helpers"
    class V1 < SpApiClient
      NOTIFICATION_PATH = "/notifications/v1"
      NOTIFICATION_SCOPE = "sellingpartnerapi::notifications"

      def create_destination(arn, name, params = {})
        @local_var_path = "#{NOTIFICATION_PATH}/destinations"
        params = params.transform_keys(&:to_s)
        @scope = NOTIFICATION_SCOPE
        destination_params = { "resourceSpecification" => { "sqs" => { "arn" => arn } }, "name" => name }
        unless params["region"].nil? || params["account_id"].nil?
          destination_params["resourceSpecification"].merge!("eventBridge" => { "region" => params["region"],
                                                                                "accountId" => params["account_id"] })
        end
        @request_body = destination_params
        @request_type = "POST"
        call_api
      end

      def get_destinations(params = {})
        @local_var_path = "#{NOTIFICATION_PATH}/destinations"
        @scope = NOTIFICATION_SCOPE
        @query_params = sp_api_params(params)
        @request_type = "GET"
        call_api
      end

      def get_destination(destination_id)
        @local_var_path = "#{NOTIFICATION_PATH}/destinations/#{destination_id}"
        @scope = NOTIFICATION_SCOPE
        @request_type = "GET"
        call_api
      end

      def create_subscription(notification_type, params = {})
        @local_var_path = "#{NOTIFICATION_PATH}/subscriptions/#{notification_type}"
        params = params.transform_keys(&:to_s)
        subscription_params = { "destinationId" => params["destination_id"],
                                "processingDirective" => { "eventFilter" => { "eventFilterType" => notification_type,
                                                                              "marketplaceIds" => params["marketplace_ids"] } } }
        unless params["aggregation_time_period"].nil?
          subscription_params["processingDirective"]["eventFilter"].merge!("aggregationSettings" => { "aggregationTimePeriod" => params["aggregation_time_period"] })
        end
        subscription_params.merge!("payloadVersion" => params["payload_version"]) unless params["payload_version"].nil?
        @request_body = subscription_params
        @request_type = "POST"
        call_api
      end

      def get_subscription(notification_type, params = {})
        @local_var_path = "#{NOTIFICATION_PATH}/subscriptions/#{notification_type}"
        @query_params = sp_api_params(params)
        @request_type = "GET"
        call_api
      end

      def get_subscription_by_id(notification_type, subscription_id)
        @local_var_path = "#{NOTIFICATION_PATH}/subscriptions/#{notification_type}/#{subscription_id}"
        @scope = NOTIFICATION_SCOPE
        @request_type = "GET"
        call_api
      end

      def delete_subscription_by_id(notification_type, subscription_id)
        @local_var_path = "#{NOTIFICATION_PATH}/subscriptions/#{notification_type}/#{subscription_id}"
        @scope = NOTIFICATION_SCOPE
        @request_type = "DELETE"
        call_api
      end
    end
  end
end
