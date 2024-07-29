# frozen_string_literal: true

RSpec.describe MuffinMan::FulfillmentInbound::V20240320 do
  subject(:fba_inbound_client) { described_class.new(credentials) }

  before do
    stub_request_access_token
  end

  describe "list_inbound_plans" do
    before do
      stub_list_inbound_plans(page_size: page_size, pagination_token: pagination, status: status, sort_by: sort_by,
                              sort_order: sort_order)
    end

    let(:page_size) { 10 }
    let(:pagination) { "token" }
    let(:status) { "ACTIVE" }
    let(:sort_by) { "LastUpdatedDate" }
    let(:sort_order) { "DESC" }

    it "lists inbound plans" do
      response = fba_inbound_client.list_inbound_plans(page_size: page_size, pagination_token: pagination,
                                                       status: status, sort_by: sort_by, sort_order: sort_order)
      expect(response.success?).to be true
      expect(JSON.parse(response.body)["inboundPlans"]).to be_an(Array)
    end
  end

  describe "get_inbound_plan" do
    let(:inbound_plan_id) { "wf03769cea-f374-4853-ab93-1a4cf8a62e35" }

    before do
      stub_get_inbound_plan(inbound_plan_id)
    end

    it "gets inbound plan by ID" do
      response = fba_inbound_client.get_inbound_plan(inbound_plan_id)
      expect(response.success?).to be true
      expect(JSON.parse(response.body)["inboundPlanId"]).to eq(inbound_plan_id)
    end
  end

  describe "get_shipment" do
    let(:inbound_plan_id) { "wf03769cea-f374-4853-ab93-1a4cf8a62e35" }
    let(:shipment_id) { "sh150f31d2-f3c0-4364-bf0a-63ee9c7ce99f" }

    before do
      stub_get_shipment_v2024(inbound_plan_id, shipment_id)
    end

    it "gets shipment by ID" do
      response = fba_inbound_client.get_shipment(inbound_plan_id, shipment_id)
      expect(response.success?).to be true
      expect(JSON.parse(response.body)["shipmentId"]).to eq(shipment_id)
    end
  end

  describe "list_shipment_boxes" do
    let(:inbound_plan_id) { "wf03769cea-f374-4853-ab93-1a4cf8a62e35" }
    let(:shipment_id) { "sh150f31d2-f3c0-4364-bf0a-63ee9c7ce99f" }
    let(:page_size) { 10 }
    let(:pagination) { "token" }

    before do
      stub_list_shipment_boxes(inbound_plan_id, shipment_id, page_size: page_size, pagination_token: pagination)
    end

    it "lists shipment boxes" do
      response = fba_inbound_client.list_shipment_boxes(inbound_plan_id, shipment_id, page_size: page_size,
                                                                                      pagination_token: pagination)
      expect(response.success?).to be true
      expect(JSON.parse(response.body)["boxes"]).to be_an(Array)
    end
  end
end
