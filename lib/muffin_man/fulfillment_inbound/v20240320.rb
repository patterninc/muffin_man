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
          sourceAddress: source_address
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
        @local_var_path = "#{INBOUND_PATH}/inboundPlans/#{inbound_plan_id}/packingOptions/#{packing_option_id}/confirmation" # rubocop:disable Layout/LineLength
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

      def list_shipment_pallets(inbound_plan_id, shipment_id, page_size: nil, pagination_token: nil)
        @local_var_path = "#{INBOUND_PATH}/inboundPlans/#{inbound_plan_id}/shipments/#{shipment_id}/pallets"
        @query_params = {}
        @query_params["pageSize"] = page_size if page_size
        @query_params["paginationToken"] = pagination_token if pagination_token
        @request_type = "GET"
        call_api
      end

      def get_self_ship_appointment_slots(inbound_plan_id, shipment_id, page_size: nil, pagination_token: nil)
        @local_var_path = "#{INBOUND_PATH}/inboundPlans/#{inbound_plan_id}/shipments/#{shipment_id}/selfShipAppointmentSlots" # rubocop:disable Layout/LineLength
        @query_params = {}
        @query_params["pageSize"] = page_size if page_size
        @query_params["paginationToken"] = pagination_token if pagination_token
        @request_type = "GET"
        call_api
      end

      def generate_self_ship_appointment_slots(inbound_plan_id, shipment_id, body)
        @local_var_path = "#{INBOUND_PATH}/inboundPlans/#{inbound_plan_id}/shipments/#{shipment_id}/selfShipAppointmentSlots" # rubocop:disable Layout/LineLength
        @request_body = body
        @request_type = "POST"
        call_api
      end

      def schedule_self_ship_appointment(inbound_plan_id, shipment_id, slot_id, body)
        @local_var_path = "#{INBOUND_PATH}/inboundPlans/#{inbound_plan_id}/shipments/#{shipment_id}/selfShipAppointmentSlots/#{slot_id}/schedule" # rubocop:disable Layout/LineLength
        @request_body = body
        @request_type = "POST"
        call_api
      end

      def list_transportation_options(inbound_plan_id, page_size: nil, pagination_token: nil, placement_option_id: nil,
                                      shipment_id: nil)
        @local_var_path = "#{INBOUND_PATH}/inboundPlans/#{inbound_plan_id}/transportationOptions"
        @query_params = {}
        @query_params["pageSize"] = page_size if page_size
        @query_params["paginationToken"] = pagination_token if pagination_token
        @query_params["placementOptionId"] = placement_option_id if placement_option_id
        @query_params["shipmentId"] = shipment_id if shipment_id
        @request_type = "GET"
        call_api
      end

      def generate_transportation_options(inbound_plan_id, body)
        @local_var_path = "#{INBOUND_PATH}/inboundPlans/#{inbound_plan_id}/transportationOptions"
        @request_body = body
        @request_type = "POST"
        call_api
      end

      def confirm_transportation_options(inbound_plan_id, body)
        @local_var_path = "#{INBOUND_PATH}/inboundPlans/#{inbound_plan_id}/transportationOptions/confirmation"
        @request_body = body
        @request_type = "POST"
        call_api
      end

      def list_item_compliance_details(mskus, marketplace_id)
        @local_var_path = "#{INBOUND_PATH}/items/compliance"
        @query_params = {}
        @query_params["mskus"] = mskus
        @query_params["marketplaceId"] = marketplace_id
        @request_type = "GET"
        call_api
      end

      def update_item_compliance_details(marketplace_id, body)
        @local_var_path = "#{INBOUND_PATH}/items/compliance"
        @query_params = {}
        @query_params["marketplaceId"] = marketplace_id
        @request_body = body
        @request_type = "PUT"
        call_api
      end

      def create_marketplace_item_labels(body)
        @local_var_path = "#{INBOUND_PATH}/items/labels"
        @request_body = body
        @request_type = "POST"
        call_api
      end

      def list_prep_details(marketplace_id, mskus)
        @local_var_path = "#{INBOUND_PATH}/items/prepDetails"
        @query_params = {}
        @query_params["marketplaceId"] = marketplace_id
        @query_params["mskus"] = mskus
        @request_type = "GET"
        call_api
      end

      def set_prep_details(body) # rubocop:disable Naming/AccessorMethodName
        @local_var_path = "#{INBOUND_PATH}/items/prepDetails"
        @request_body = body
        @request_type = "POST"
        call_api
      end

      def generate_shipment_content_update_previews(inbound_plan_id, shipment_id, body)
        @local_var_path = "#{INBOUND_PATH}/inboundPlans/#{inbound_plan_id}/shipments/#{shipment_id}/contentUpdatePreviews"
        @request_body = body
        @request_type = "POST"
        call_api
      end

      def get_shipment_content_update_preview(inbound_plan_id, shipment_id, content_update_preview_id)
        @local_var_path = "#{INBOUND_PATH}/inboundPlans/#{inbound_plan_id}/shipments/#{shipment_id}/contentUpdatePreviews/#{content_update_preview_id}" # rubocop:disable Layout/LineLength
        @request_type = "GET"
        call_api
      end

      def confirm_shipment_content_update_preview(inbound_plan_id, shipment_id, content_update_preview_id)
        @local_var_path = "#{INBOUND_PATH}/inboundPlans/#{inbound_plan_id}/shipments/#{shipment_id}/contentUpdatePreviews/#{content_update_preview_id}/confirmation" # rubocop:disable Layout/LineLength
        @request_type = "POST"
        call_api
      end

      def list_shipment_content_update_previews(inbound_plan_id, shipment_id, page_size: nil, pagination_token: nil)
        @local_var_path = "#{INBOUND_PATH}/inboundPlans/#{inbound_plan_id}/shipments/#{shipment_id}/contentUpdatePreviews"
        @query_params = {}
        @query_params["pageSize"] = page_size if page_size
        @query_params["paginationToken"] = pagination_token if pagination_token
        @request_type = "GET"
        call_api
      end
    end
  end
end
