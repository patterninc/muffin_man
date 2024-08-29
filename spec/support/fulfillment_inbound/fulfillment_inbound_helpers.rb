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
    end
  end
end
