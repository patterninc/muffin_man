RSpec.describe MuffinMan::MerchantFulfillment::V0 do
  before do
    stub_request_access_token
  end

  subject(:merchant_fulfillment_client) { described_class.new(credentials) }

  let(:request_details) do
    {
      "AmazonOrderId": "string",
      "ItemList": [
        {
          "OrderItemId": "string",
          "Quantity": 0,
          "ItemWeight": {
            "Value": 0,
            "Unit": "oz"
          },
        }
      ],
      "ShipFromAddress": {
        "Name": "string",
        "AddressLine1": "string",
        "AddressLine2": "string",
        "AddressLine3": "string",
        "DistrictOrCounty": "string",
        "Email": "string",
        "City": "string",
        "StateOrProvinceCode": "string",
        "PostalCode": "string",
        "CountryCode": "string",
        "Phone": "string"
      },
      "PackageDimensions": {
        "Length": 0,
        "Width": 0,
        "Height": 0,
        "Unit": "inches",
        "PredefinedPackageDimensions": "FedEx_Box_10kg"
      },
      "Weight": {
        "Value": 0,
        "Unit": "oz"
      },
      "MustArriveByDate": "2022-11-08T15:31:57.377Z",
      "ShipDate": "2022-11-08T15:31:57.377Z",
      "ShippingServiceOptions": {
        "DeliveryExperience": "DeliveryConfirmationWithAdultSignature",
        "DeclaredValue": {
          "CurrencyCode": "str",
          "Amount": 0
        },
        "CarrierWillPickUp": true,
        "CarrierWillPickUpOption": "CarrierWillPickUp",
        "LabelFormat": "PDF"
      },
    }
  end

  describe "get_eligible_shipment_services" do
    before { stub_get_eligible_shipment_services }

    let(:shipping_offering_filter) do
      {
        "IncludePackingSlipWithLabel": true,
        "IncludeComplexShippingOptions": true,
        "CarrierWillPickUp": "CarrierWillPickUp",
        "DeliveryExperience": "DeliveryConfirmationWithoutSignature"
      }
    end

    it 'makes a call to get shipment services' do
      response = merchant_fulfillment_client.get_eligible_shipment_services(request_details, shipping_offering_filter)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body).dig("payload", "ShippingServiceList").count > 0).to be true
    end
  end

  describe "get_shipment" do
    let(:shipment_id) { "SENDTODRURYLANE" }
    before { stub_get_shipment }

    it 'makes a call to get shipment info' do
      response = merchant_fulfillment_client.get_shipment(shipment_id)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body).dig("payload", "ShipmentId")).not_to be_nil
    end
  end

  describe "cancel_shipment" do
    let(:shipment_id) { "SENDTODRURYLANE" }
    before { stub_cancel_shipment }

    it 'makes a call to delete a shipment' do
      response = merchant_fulfillment_client.cancel_shipment(shipment_id)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body).dig("payload", "ShipmentId")).not_to be_nil
    end
  end

  describe "create_shipment" do
    let(:shipping_service_id) { "BlueberryMuffin" }
    before { stub_create_shipment }

    it 'makes a call to create a shipment' do
      response = merchant_fulfillment_client.create_shipment(request_details, shipping_service_id)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body).dig("payload", "ShipmentId")).not_to be_nil
    end
  end

  describe "get_additional_seller_inputs" do
    let(:shipping_service_id) { "BlueberryMuffin" }
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
    let(:order_id) { "DoYouKnowTheMuffinMan" }
    before { stub_get_additional_seller_inputs }

    it 'makes a call to get additional seller inputs' do
      response = merchant_fulfillment_client.get_additional_seller_inputs(shipping_service_id, address, order_id)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body).dig("payload", "ShipmentLevelFields").count > 0).to be true
    end
  end
end
