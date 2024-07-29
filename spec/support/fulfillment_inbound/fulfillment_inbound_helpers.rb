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
    end
  end
end
