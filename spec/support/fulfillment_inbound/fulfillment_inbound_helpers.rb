# frozen_string_literal: true

module Support
  module FulfillmentInbound
    module FulfillmentInboundHelpers
      def stub_list_inbound_plans(page_size: nil, pagination_token: nil, status: nil, sort_by: nil, sort_order: nil)
        stub_request(:get, "https://#{hostname}/inbound/fba/2024-03-20/inboundPlans")
          .with(query: { pageSize: page_size, paginationToken: pagination_token, status: status, sortBy: sort_by,
                         sortOrder: sort_order }.compact)
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/list_inbound_plans.json"),
            headers: {}
          )
      end

      def stub_get_inbound_plan(inbound_plan_id)
        stub_request(:get, "https://#{hostname}/inbound/fba/2024-03-20/inboundPlans/#{inbound_plan_id}")
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/get_inbound_plan.json"),
            headers: {}
          )
      end

      def stub_get_shipment_v2024(inbound_plan_id, shipment_id)
        stub_request(:get, "https://#{hostname}/inbound/fba/2024-03-20/inboundPlans/#{inbound_plan_id}/shipments/#{shipment_id}")
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/get_shipment.json"),
            headers: {}
          )
      end

      def stub_list_shipment_boxes(inbound_plan_id, shipment_id, page_size: nil, pagination_token: nil)
        stub_request(:get, "https://#{hostname}/inbound/fba/2024-03-20/inboundPlans/#{inbound_plan_id}/shipments/#{shipment_id}/boxes")
          .with(query: { pageSize: page_size, paginationToken: pagination_token }.compact)
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/list_shipment_boxes.json"),
            headers: {}
          )
      end

      def stub_create_inbound_plan(destination_marketplaces, items, source_address, name: nil)
        stub_request(:post, "https://#{hostname}/inbound/fba/2024-03-20/inboundPlans")
          .with(
            body: {
              destinationMarketplaces: destination_marketplaces,
              items: items,
              sourceAddress: source_address,
              name: name
            }.compact
          )
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/operation_response.json"),
            headers: {}
          )
      end

      def stub_generate_packing_options(inbound_plan_id)
        stub_request(:post, "https://#{hostname}/inbound/fba/2024-03-20/inboundPlans/#{inbound_plan_id}/packingOptions")
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/operation_response.json"),
            headers: {}
          )
      end

      def stub_generate_placement_options(inbound_plan_id)
        stub_request(:post, "https://#{hostname}/inbound/fba/2024-03-20/inboundPlans/#{inbound_plan_id}/placementOptions")
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/operation_response.json"),
            headers: {}
          )
      end

      def stub_list_packing_options(inbound_plan_id)
        stub_request(:get, "https://#{hostname}/inbound/fba/2024-03-20/inboundPlans/#{inbound_plan_id}/packingOptions")
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/list_packing_options.json"),
            headers: {}
          )
      end

      def stub_list_packing_group_items(inbound_plan_id, packing_group_id, page_size: nil, pagination_token: nil)
        stub_request(:get, "https://#{hostname}/inbound/fba/2024-03-20/inboundPlans/#{inbound_plan_id}/packingGroups/#{packing_group_id}/items")
          .with(query: { pageSize: page_size, paginationToken: pagination_token }.compact)
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/list_packing_group_items.json"),
            headers: {}
          )
      end

      def stub_confirm_packing_option(inbound_plan_id, packing_option_id)
        stub_request(:post, "https://#{hostname}/inbound/fba/2024-03-20/inboundPlans/#{inbound_plan_id}/packingOptions/#{packing_option_id}/confirmation")
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/operation_response.json"),
            headers: {}
          )
      end

      def stub_set_packing_information(inbound_plan_id, body)
        stub_request(:post, "https://#{hostname}/inbound/fba/2024-03-20/inboundPlans/#{inbound_plan_id}/packingInformation")
          .with(body: body)
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/operation_response.json"),
            headers: {}
          )
      end

      def stub_list_placement_options(inbound_plan_id)
        stub_request(:get, "https://#{hostname}/inbound/fba/2024-03-20/inboundPlans/#{inbound_plan_id}/placementOptions")
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/list_placement_options.json"),
            headers: {}
          )
      end

      def stub_get_inbound_operation_status(operation_id)
        stub_request(:get, "https://#{hostname}/inbound/fba/2024-03-20/operations/#{operation_id}")
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/get_inbound_operation_status.json"),
            headers: {}
          )
      end

      def stub_list_inbound_plan_items(inbound_plan_id, page_size: nil, pagination_token: nil)
        stub_request(:get, "https://#{hostname}/inbound/fba/2024-03-20/inboundPlans/#{inbound_plan_id}/items")
          .with(query: { pageSize: page_size, paginationToken: pagination_token }.compact)
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/list_inbound_plan_items.json"),
            headers: {}
          )
      end

      def stub_list_shipment_pallets
        stub_request(:get, "https://#{hostname}/inbound/fba/2024-03-20/inboundPlans/#{inbound_plan_id}/shipments/#{shipment_id}/pallets")
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/list_shipment_pallets.json"),
            headers: {}
          )
      end

      def stub_get_self_ship_appointment_slots
        stub_request(:get, "https://#{hostname}/inbound/fba/2024-03-20/inboundPlans/#{inbound_plan_id}/shipments/#{shipment_id}/selfShipAppointmentSlots")
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/get_self_ship_appointment_slots.json"),
            headers: {}
          )
      end

      def stub_generate_self_ship_appointment_slots
        stub_request(:post, "https://#{hostname}/inbound/fba/2024-03-20/inboundPlans/#{inbound_plan_id}/shipments/#{shipment_id}/selfShipAppointmentSlots")
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/generate_self_ship_appointment_slots.json"),
            headers: {}
          )
      end

      def stub_schedule_self_ship_appointment
        stub_request(:post, "https://#{hostname}/inbound/fba/2024-03-20/inboundPlans/#{inbound_plan_id}/shipments/#{shipment_id}/selfShipAppointmentSlots/#{slot_id}/schedule")
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/schedule_self_ship_appointment.json"),
            headers: {}
          )
      end

      def stub_list_transportation_options(inbound_plan_id)
        stub_request(:get, "https://#{hostname}/inbound/fba/2024-03-20/inboundPlans/#{inbound_plan_id}/transportationOptions")
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/list_transportation_options.json"),
            headers: {}
          )
      end

      def stub_generate_transportation_options
        stub_request(:post, "https://#{hostname}/inbound/fba/2024-03-20/inboundPlans/#{inbound_plan_id}/transportationOptions")
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/generate_transportation_options.json"),
            headers: {}
          )
      end

      def stub_confirm_transportation_options
        stub_request(:post, "https://#{hostname}/inbound/fba/2024-03-20/inboundPlans/#{inbound_plan_id}/transportationOptions/confirmation")
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/confirm_transportation_options.json"),
            headers: {}
          )
      end

      def stub_list_item_compliance_details
        stub_request(:get, "https://#{hostname}/inbound/fba/2024-03-20/items/compliance")
          .with(query: { mskus: mskus, marketplaceId: marketplace_id })
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/list_item_compliance_details.json"),
            headers: {}
          )
      end

      def stub_update_item_compliance_details
        stub_request(:put, "https://#{hostname}/inbound/fba/2024-03-20/items/compliance")
          .with(query: { marketplaceId: marketplace_id })
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/update_item_compliance_details.json"),
            headers: {}
          )
      end

      def stub_create_marketplace_item_labels
        stub_request(:post, "https://#{hostname}/inbound/fba/2024-03-20/items/labels")
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/create_marketplace_item_labels.json"),
            headers: {}
          )
      end

      def stub_list_prep_details
        stub_request(:get, "https://#{hostname}/inbound/fba/2024-03-20/items/prepDetails")
          .with(query: { marketplaceId: marketplace_id, mskus: mskus })
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/list_prep_details.json"),
            headers: {}
          )
      end

      def stub_set_prep_details(prep_details)
        stub_request(:post, "https://#{hostname}/inbound/fba/2024-03-20/items/prepDetails")
          .with(body: prep_details)
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/set_prep_details.json"),
            headers: {}
          )
      end

      def stub_list_shipment_items(inbound_plan_id, shipment_id, page_size: nil, pagination_token: nil)
        stub_request(:get, "https://#{hostname}/inbound/fba/2024-03-20/inboundPlans/#{inbound_plan_id}/shipments/#{shipment_id}/items")
          .with(query: { pageSize: page_size, paginationToken: pagination_token }.compact)
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/list_shipment_items.json"),
            headers: {}
          )
      end

      def stub_generate_shipment_content_update_previews
        stub_request(:post, "https://#{hostname}/inbound/fba/2024-03-20/inboundPlans/#{inbound_plan_id}/shipments/#{shipment_id}/contentUpdatePreviews")
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/generate_shipment_content_update_previews.json"),
            headers: {}
          )
      end

      def stub_get_shipment_content_update_preview
        stub_request(:get, "https://#{hostname}/inbound/fba/2024-03-20/inboundPlans/#{inbound_plan_id}/shipments/#{shipment_id}/contentUpdatePreviews/#{content_update_preview_id}")
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/get_shipment_content_update_preview.json"),
            headers: {}
          )
      end

      def stub_confirm_shipment_content_update_preview
        stub_request(:post, "https://#{hostname}/inbound/fba/2024-03-20/inboundPlans/#{inbound_plan_id}/shipments/#{shipment_id}/contentUpdatePreviews/#{content_update_preview_id}/confirmation")
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/confirm_shipment_content_update_preview.json"),
            headers: {}
          )
      end

      def stub_list_shipment_content_update_previews
        stub_request(:get, "https://#{hostname}/inbound/fba/2024-03-20/inboundPlans/#{inbound_plan_id}/shipments/#{shipment_id}/contentUpdatePreviews")
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/list_shipment_content_update_previews.json"),
            headers: {}
          )
      end

      def stub_confirm_placement_option
        stub_request(:post, "https://#{hostname}/inbound/fba/2024-03-20/inboundPlans/#{inbound_plan_id}/placementOptions/#{placement_option_id}/confirmation")
          .to_return(
            status: 202,
            body: File.read("./spec/support/fulfillment_inbound/operation_response.json"),
            headers: {}
          )
      end

      def stub_cancel_inbound_plan
        stub_request(:put, "https://#{hostname}/inbound/fba/2024-03-20/inboundPlans/#{inbound_plan_id}/cancellation")
          .to_return(
            status: 202,
            body: File.read("./spec/support/fulfillment_inbound/operation_response.json"),
            headers: {}
          )
      end

      def stub_generate_delivery_window_options
        stub_request(:post, "https://#{hostname}/inbound/fba/2024-03-20/inboundPlans/#{inbound_plan_id}/shipments/#{shipment_id}/deliveryWindowOptions")
          .to_return(
            status: 202,
            body: File.read("./spec/support/fulfillment_inbound/operation_response.json"),
            headers: {}
          )
      end

      def stub_list_delivery_window_options
        stub_request(:get, "https://#{hostname}/inbound/fba/2024-03-20/inboundPlans/#{inbound_plan_id}/shipments/#{shipment_id}/deliveryWindowOptions")
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/list_delivery_window_options.json"),
            headers: {}
          )
      end

      def stub_confirm_delivery_window_options
        stub_request(:post, "https://#{hostname}/inbound/fba/2024-03-20/inboundPlans/#{inbound_plan_id}/shipments/#{shipment_id}/deliveryWindowOptions/#{delivery_window_option_id}/confirmation")
          .to_return(
            status: 202,
            body: File.read("./spec/support/fulfillment_inbound/operation_response.json"),
            headers: {}
          )
      end

      def stub_list_inbound_plan_boxes
        stub_request(:get, "https://#{hostname}/inbound/fba/2024-03-20/inboundPlans/#{inbound_plan_id}/boxes")
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/list_inbound_plan_boxes.json"),
            headers: {}
          )
      end

      def stub_update_shipment_tracking_details
        stub_request(:put, "https://#{hostname}/inbound/fba/2024-03-20/inboundPlans/#{inbound_plan_id}/shipments/#{shipment_id}/trackingDetails")
          .to_return(
            status: 200,
            body: File.read("./spec/support/fulfillment_inbound/update_shipment_tracking_details.json"),
            headers: {}
          )
      end
    end
  end
end
