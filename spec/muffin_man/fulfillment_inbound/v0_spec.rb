RSpec.describe MuffinMan::FulfillmentInbound::V0 do
  before do
    stub_request_access_token
  end

  let(:country_code) { "US" }
  let(:sku_list) { ["SD-ABC-12345"] }
  let(:address) do
    {
      "Name"=>"The Muffin Man",
      "AddressLine1"=>"12345 Drury Lane",
      "AddressLine2"=>nil,
      "City"=>"CandyLand",
      "DistrictOrCounty"=>nil,
      "StateOrProvinceCode"=>"CL",
      "CountryCode"=>"US",
      "PostalCode"=>"12345"
    }
  end

  subject(:fba_inbound_client) { described_class.new(credentials) }

  describe "get_prep_instructions" do
    before { stub_get_prep_instructions }

    it "makes a request to get prep instructions for a SKU/country" do
      expect(fba_inbound_client.get_prep_instructions(country_code, seller_sku_list: sku_list).response_code).to eq(200)
      expect(JSON.parse(fba_inbound_client.get_prep_instructions(country_code, seller_sku_list: sku_list).body).dig("payload", "SKUPrepInstructionsList").first["SellerSKU"]).to eq(sku_list.first)
    end
  end

  describe "create_inbound_shipment_plan" do
    before { stub_create_inbound_shipment_plan }
    let(:label_prep_preference) { "SELLER_LABEL" }
    let(:inbound_shipment_plan_request_items) do
      [
        {
          "SellerSKU"=>"SD-ABC-123456",
          "ASIN"=>"B123456JKL",
          "Quantity"=>1,
          "QuantityInCase"=>nil,
          "PrepDetailsList"=>[],
          "Condition"=>"NewItem",
        }
      ]
    end

    it "makes a request to create an inbound shipment plan" do
      response = fba_inbound_client.create_inbound_shipment_plan(address, label_prep_preference, inbound_shipment_plan_request_items)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body).dig("payload", "InboundShipmentPlans").first["ShipmentId"]).to eq('FBA16WN8GFP1')
    end
  end

  describe "create_inbound_shipment" do
    before { stub_create_inbound_shipment }
    let(:inbound_shipment_header) do
      {
        "ShipmentName" => "TEST SHIPMENT",
        "ShipFromAddress" => address,
        "DestinationFulfillmentCenterId" => "BFI9",
        "LabelPrepPreference" => "SELLER_LABEL",
        "AreCasesRequired" => false,
        "ShipmentStatus" => "WORKING",
        "IntendedBoxContentsSource" => "FEED"
      }
    end
    let(:inbound_shipment_items) { [ {"SellerSKU"=>"SD-ABC-12345", "QuantityShipped"=>1} ] }
    let(:shipment_id) { "FBA1232453KJ" }
    let(:marketplace_id) { "ATVPDKIKX0DER" }

    it "makes a request to create an inbound shipment" do
      response = fba_inbound_client.create_inbound_shipment(shipment_id, marketplace_id, inbound_shipment_header, inbound_shipment_items)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body).dig("payload", "ShipmentId")).to eq(shipment_id)
    end
  end

  describe "get_shipments" do
    before { stub_get_shipments }
    let(:shipment_id_list) { ["FBA1232453KJ"] }
    let(:marketplace_id) { "ATVPDKIKX0DER" }
    let(:query_type) { "SHIPMENT" }

    it "makes a request to get a shipment" do
      response = fba_inbound_client.get_shipments(query_type, marketplace_id, shipment_id_list: shipment_id_list)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body).dig("payload", "ShipmentData")).not_to be_nil
    end
  end

  describe "update_inbound_shipment" do
    before { stub_update_inbound_shipment }
    let(:inbound_shipment_header) do
      {
        "ShipmentName" => "TEST SHIPMENT",
        "ShipFromAddress" => address,
        "DestinationFulfillmentCenterId" => "BFI9",
        "LabelPrepPreference" => "SELLER_LABEL",
        "AreCasesRequired" => false,
        "ShipmentStatus" => "WORKING",
        "IntendedBoxContentsSource" => "FEED"
      }
    end
    let(:inbound_shipment_items) { [ {"SellerSKU"=>"SD-ABC-12345", "QuantityShipped"=>1} ] }
    let(:shipment_id) { "FBA1232453KJ" }
    let(:marketplace_id) { "ATVPDKIKX0DER" }

    it "makes a request to update an inbound shipment" do
      response = fba_inbound_client.update_inbound_shipment(shipment_id, marketplace_id, inbound_shipment_header, inbound_shipment_items)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body).dig("payload", "ShipmentId")).to eq(shipment_id)
    end
  end

  describe "get_labels" do
    before { stub_get_labels }
    let(:shipment_id) { "FBA1232453KJ" }
    let(:page_type) { "PackageLabel_Plain_Paper" }
    let(:label_type) { "UNIQUE" }
    let(:package_labels_to_print) { ["FBA12A3B4CDEFG5H1", "FBA12A3B4CDEFG5H2", "FBA12A3B4CDEFG5H3", "FBA12A3B4CDEFG5H4"] }

    it "makes a request to get labels" do
      response = fba_inbound_client.get_labels(shipment_id, page_type, label_type, package_labels_to_print: package_labels_to_print)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body).dig("payload", "DownloadURL")).not_to be_nil
    end
  end

  describe "get_shipment_items_by_shipment_id" do
    before { stub_get_shipment_items_by_shipment_id }
    let(:shipment_id) { "FBA1232453KJ" }
    let(:marketplace_id) { "ATVPDKIKX0DER" }

    it "makes a request to create an inbound shipment" do
      response = fba_inbound_client.get_shipment_items_by_shipment_id(shipment_id, marketplace_id)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body).dig("payload", "ItemData")).not_to be_empty
    end
  end

  describe "put_transport_details" do
    before { stub_put_transport_details }
    let(:shipment_id) { "FBA1232453KJ" }
    let(:is_partnered) { true }
    let(:shipment_type) { "LPL" }
    let(:transport_details) do [
        {
          "PartneredSmallParcelData"=>[],
          "NonPartneredSmallParcelData"=>[],
          "PartneredLtlData"=>[],
          "NonPartneredLtlData"=>[]
        }
      ]
    end
    let(:transport_result) do [
        {
          "TransportStatus"=>"WORKING",
          "ErrorCode"=>"",
          "ErrorDescription"=>""
        }
      ]
    end


    it "makes a request to put transport details to amazon" do
      response = fba_inbound_client.put_transport_details(shipment_id, is_partnered, shipment_type, transport_details)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body).dig("payload", "TransportResult")).to eq(transport_result)
    end
  end

  describe "estimate_transport" do
    before { stub_estimate_transport }
    let(:shipment_id) { "FBA1232453KJ" }

    it "makes a request to estimate transport cost" do
      response = fba_inbound_client.estimate_transport(shipment_id)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body).dig("payload", "TransportResult", "TransportStatus")).not_to be_empty
    end
  end

  describe "get transport details" do
    before { stub_get_transport_details }
    let(:shipment_id) { "FBA1232453KJ" }

    it "makes a request to get transport details" do
      response = fba_inbound_client.get_transport_details(shipment_id)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body).dig("payload", "TransportContent", "TransportDetails")).not_to be_empty
    end
  end

  describe "confirm transport" do
    before { stub_confirm_transport }
    let(:shipment_id) { "FBA1232453KJ" }

    it "makes a request to confirm transport" do
      response = fba_inbound_client.confirm_transport(shipment_id)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body).dig("payload", "TransportResult", "TransportStatus")).not_to be_empty
    end
  end

  describe "void transport" do
    before { stub_void_transport }
    let(:shipment_id) { "FBA1232453KJ" }

    it "makes a request to confirm transport" do
      response = fba_inbound_client.void_transport(shipment_id)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body).dig("payload", "TransportResult", "TransportStatus")).not_to be_empty
    end
  end
end
