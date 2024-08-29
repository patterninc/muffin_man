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

  describe "list_inbound_plan_items" do
    let(:inbound_plan_id) { "wf03769cea-f374-4853-ab93-1a4cf8a62e35" }
    let(:page_size) { 10 }
    let(:pagination_token) { "token" }

    before do
      stub_list_inbound_plan_items(inbound_plan_id, page_size: page_size, pagination_token: pagination_token)
    end

    it "lists inbound plan items" do
      response = fba_inbound_client.list_inbound_plan_items(inbound_plan_id, page_size: page_size,
                                                                      pagination_token: pagination_token)
      expect(response.success?).to be true
      expect(JSON.parse(response.body)["items"]).to be_an(Array)
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

  describe "create_inbound_plan" do
    let(:destination_marketplaces) { [ "ATVPDKIKX0DER" ] }
    let(:items) do
      [
        {
          expiration: "2024-01-01",
          labelOwner: "AMAZON",
          manufacturingLotCode: "manufacturingLotCode",
          msku: "Sunglasses",
          prepOwner: "AMAZON",
          quantity: 10
        }
      ]
    end
    let(:source_address) do
      {
        addressLine1: "123 example street",
        addressLine2: "Floor 19",
        city: "Toronto",
        companyName: "Acme",
        countryCode: "CA",
        email: "email@email.com",
        name: "name",
        phoneNumber: "1234567890",
        postalCode: "M1M1M1",
        stateOrProvinceCode: "ON"
      }
    end
    let(:name) { "My inbound plan" }
    before { stub_create_inbound_plan(destination_marketplaces, items, source_address, name: name) }

    it "creates an inbound plan" do
      response = fba_inbound_client.create_inbound_plan(destination_marketplaces, items, source_address, name: name)
      expect(response.success?).to be true
      expect(JSON.parse(response.body)["inboundPlanId"]).not_to be_nil
    end
  end

  describe "generate_packing_options" do
    let(:inbound_plan_id) { "wf03769cea-f374-4853-ab93-1a4cf8a62e35" }
    before { stub_generate_packing_options(inbound_plan_id) }

    it "generates packing options" do
      response = fba_inbound_client.generate_packing_options(inbound_plan_id)
      expect(response.success?).to be true
      expect(JSON.parse(response.body)["operationId"]).not_to be_nil
    end
  end

  describe "list_packing_options" do
    let(:inbound_plan_id) { "wf03769cea-f374-4853-ab93-1a4cf8a62e35" }
    before { stub_list_packing_options(inbound_plan_id) }

    it "lists packing options" do
      response = fba_inbound_client.list_packing_options(inbound_plan_id)
      expect(response.success?).to be true
      expect(JSON.parse(response.body)["packingOptions"]).to be_an(Array)
    end
  end

  describe "list_packing_group_items" do
    let(:inbound_plan_id) { "wf03769cea-f374-4853-ab93-1a4cf8a62e35" }
    let(:packing_group_id) { "pg150f31d2-f3c0-4364-bf0a-63ee9c7ce99f" }
    let(:page_size) { 10 }
    let(:pagination_token) { "token" }
    before { stub_list_packing_group_items(inbound_plan_id, packing_group_id, page_size: page_size, pagination_token: pagination_token) }

    it "lists packing group items" do
      response = fba_inbound_client.list_packing_group_items(inbound_plan_id, packing_group_id, page_size: page_size, pagination_token: pagination_token)
      expect(response.success?).to be true
      expect(JSON.parse(response.body)["items"]).to be_an(Array)
    end
  end

  describe "confirm_packing_option" do
    let(:inbound_plan_id) { "wf03769cea-f374-4853-ab93-1a4cf8a62e35" }
    let(:packing_option_id) { "po150f31d2-f3c0-4364-bf0a-63ee9c7ce99f" }
    before { stub_confirm_packing_option(inbound_plan_id, packing_option_id) }

    it "confirms packing option" do
      response = fba_inbound_client.confirm_packing_option(inbound_plan_id, packing_option_id)
      expect(response.success?).to be true
      expect(JSON.parse(response.body)["operationId"]).not_to be_nil
    end
  end

  describe "set_packing_information" do
    let(:inbound_plan_id) { "wf03769cea-f374-4853-ab93-1a4cf8a62e35" }
    let(:body) do
      {
        packageGroupings: [
          {
            packingGroupId: "pg150f31d2-f3c0-4364-bf0a-63ee9c7ce99f",
            boxes: [
              {
                weight: {
                  unit: "LB",
                  value: 0
                },
                dimensions: {
                  unitOfMeasurement: "IN",
                  length: 0,
                  width: 0,
                  height: 0
                },
                quantity: 1,
                boxId: "boxId",
                items: [
                  {
                    msku: "Sunglasses",
                    quantity: 1,
                    expiration: "2024-01-01",
                    prepOwner: "AMAZON",
                    labelOwner: "AMAZON",
                    manufacturingLotCode: "manufacturingLotCode"
                  }
                ],
                contentInformationSource: "BOX_CONTENT_PROVIDED"
              }
            ]
          }
        ]
      }
    end
    before { stub_set_packing_information(inbound_plan_id, body) }

    it "sets packing information" do
      response = fba_inbound_client.set_packing_information(inbound_plan_id, body)
      expect(response.success?).to be true
      expect(JSON.parse(response.body)["operationId"]).not_to be_nil
    end
  end

  describe "generate_placement_options" do
    let(:inbound_plan_id) { "wf03769cea-f374-4853-ab93-1a4cf8a62e35" }
    before { stub_generate_placement_options(inbound_plan_id) }

    it "generates placement options" do
      response = fba_inbound_client.generate_placement_options(inbound_plan_id)
      expect(response.success?).to be true
      expect(JSON.parse(response.body)["operationId"]).not_to be_nil
    end
  end

  describe "list_placement_options" do
    let(:inbound_plan_id) { "wf03769cea-f374-4853-ab93-1a4cf8a62e35" }
    before { stub_list_placement_options(inbound_plan_id) }

    it "lists placement options" do
      response = fba_inbound_client.list_placement_options(inbound_plan_id)
      expect(response.success?).to be true
      expect(JSON.parse(response.body)["placementOptions"]).to be_an(Array)
    end
  end

  describe "get_inbound_operation_status" do
    let(:operation_id) { "op150f31d2-f3c0-4364-bf0a-63ee9c7ce99f" }
    before { stub_get_inbound_operation_status(operation_id) }

    it "gets inbound operation status" do
      response = fba_inbound_client.get_inbound_operation_status(operation_id)
      expect(response.success?).to be true
      expect(JSON.parse(response.body)["operationId"]).not_to be_nil
    end
  end

end
