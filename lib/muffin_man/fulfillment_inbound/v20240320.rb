# frozen_string_literal: true

module MuffinMan
  module FulfillmentInbound
    class V20240320 < SpApiClient
      INBOUND_PATH = "/inbound/fba/2024-03-20"

      def list_inbound_plans(page_size: nil, pagination_token: nil, status: nil, sort_by: nil, sort_order: nil)
        @local_var_path = "#{INBOUND_PATH}/inboundPlans"
        @query_params = {}
        @query_params["pageSize"] = page_size if page_size
        @query_params["paginationToken"] = pagination_token if pagination_token
        @query_params["status"] = status if status
        @query_params["sortBy"] = sort_by if sort_by
        @query_params["sortOrder"] = sort_order if sort_order
        @request_type = "GET"
        call_api
      end

      def list_inbound_plan_items(inbound_plan_id, page_size: nil, pagination_token: nil)
        @local_var_path = "#{INBOUND_PATH}/inboundPlans/#{inbound_plan_id}/items"
        @query_params = {}
        @query_params["pageSize"] = page_size if page_size
        @query_params["paginationToken"] = pagination_token if pagination_token
        @request_type = "GET"
        call_api
      end

      def get_inbound_plan(inbound_plan_id)
        @local_var_path = "#{INBOUND_PATH}/inboundPlans/#{inbound_plan_id}"
        @request_type = "GET"
        call_api
      end

      def get_shipment(inbound_plan_id, shipment_id)
        @local_var_path = "#{INBOUND_PATH}/inboundPlans/#{inbound_plan_id}/shipments/#{shipment_id}"
        @request_type = "GET"
        call_api
      end

      def list_shipment_boxes(inbound_plan_id, shipment_id, page_size: nil, pagination_token: nil)
        @local_var_path = "#{INBOUND_PATH}/inboundPlans/#{inbound_plan_id}/shipments/#{shipment_id}/boxes"
        @query_params = {}
        @query_params["pageSize"] = page_size if page_size
        @query_params["paginationToken"] = pagination_token if pagination_token
        @request_type = "GET"
        call_api
      end

      def create_inbound_plan(destination_marketplaces, items, source_address, name: nil)
        @local_var_path = "#{INBOUND_PATH}/inboundPlans"
        @query_params = {}
        @request_body = {
          destinationMarketplaces: Array.wrap(destination_marketplaces),
          items: items,
          sourceAddress: source_address,
        }
        @request_body["name"] = name if name
        @request_type = "POST"
        call_api
      end

      def generate_packing_options(inbound_plan_id)
        @local_var_path = "#{INBOUND_PATH}/inboundPlans/#{inbound_plan_id}/packingOptions"
        @request_type = "POST"
        call_api
      end

      def list_packing_options(inbound_plan_id, page_size: nil, pagination_token: nil)
        @local_var_path = "#{INBOUND_PATH}/inboundPlans/#{inbound_plan_id}/packingOptions"
        @query_params = {}
        @query_params["pageSize"] = page_size if page_size
        @query_params["paginationToken"] = pagination_token if pagination_token
        @request_type = "GET"
        call_api
      end

      def list_packing_group_items(inbound_plan_id, packing_group_id, page_size: nil, pagination_token: nil)
        @local_var_path = "#{INBOUND_PATH}/inboundPlans/#{inbound_plan_id}/packingGroups/#{packing_group_id}/items"
        @query_params = {}
        @query_params["pageSize"] = page_size if page_size
        @query_params["paginationToken"] = pagination_token if pagination_token
        @request_type = "GET"
        call_api
      end

      def confirm_packing_option(inbound_plan_id, packing_option_id)
        @local_var_path = "#{INBOUND_PATH}/inboundPlans/#{inbound_plan_id}/packingOptions/#{packing_option_id}/confirmation"
        @request_type = "POST"
        call_api
      end

      def set_packing_information(inbound_plan_id, body)
        @local_var_path = "#{INBOUND_PATH}/inboundPlans/#{inbound_plan_id}/packingInformation"
        @request_body = body
        @request_type = "POST"
        call_api
      end

      def generate_placement_options(inbound_plan_id)
        @local_var_path = "#{INBOUND_PATH}/inboundPlans/#{inbound_plan_id}/placementOptions"
        @request_type = "POST"
        call_api
      end

      def list_placement_options(inbound_plan_id, page_size: nil, pagination_token: nil)
        @local_var_path = "#{INBOUND_PATH}/inboundPlans/#{inbound_plan_id}/placementOptions"
        @query_params = {}
        @query_params["pageSize"] = page_size if page_size
        @query_params["paginationToken"] = pagination_token if pagination_token
        @request_type = "GET"
        call_api
      end

      def get_inbound_operation_status(operation_id)
        @local_var_path = "#{INBOUND_PATH}/operations/#{operation_id}"
        @request_type = "GET"
        call_api
      end
    end
  end
end
