RSpec.describe MuffinMan::FulfillmentOutbound::V20200701 do
  before do
    stub_request_access_token
  end

  let(:country_code) { "US" }
  let(:query_start_date) {"2020-10-10"}
  let(:next_token) {"token"}
  let(:seller_fulfillment_order_id) {"19-XXXXX-50736"}


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

  let(:items) do 
    [
      {
        :sellerSku=>"SD-P4L-104525", 
        :sellerFulfillmentOrderItemId=>"10048980045217", 
        :quantity=>1
      }
    ]
  end

  subject(:fba_outbound_client) { described_class.new(credentials) }

  describe "get_fulfillment_preview" do
    before { stub_get_outbound_fulfillment_preview }
    
    it "makes a request to get outbound fulfillment preview" do
      expect(fba_outbound_client.get_fulfillment_preview(address,items).response_code).to eq(200)
      expect(JSON.parse(fba_outbound_client.get_fulfillment_preview(address,items).body).dig("payload", "fulfillmentPreviews").first["shippingSpeedCategory"]).to eq("Expedited")
      expect(JSON.parse(fba_outbound_client.get_fulfillment_preview(address,items).body).dig("payload", "fulfillmentPreviews")[1]["shippingSpeedCategory"]).to eq("Priority")
      expect(JSON.parse(fba_outbound_client.get_fulfillment_preview(address,items).body).dig("payload", "fulfillmentPreviews")[2]["shippingSpeedCategory"]).to eq("Standard")
    end    
  end

  describe "get_fulfillment_preview" do
    before { stub_get_outbound_fulfillment_preview }
    
    it "makes a request to get outbound fulfillment preview" do
      expect(fba_outbound_client.get_fulfillment_preview(address,items).response_code).to eq(200)
      expect(JSON.parse(fba_outbound_client.get_fulfillment_preview(address,items).body).dig("payload", "fulfillmentPreviews").first["shippingSpeedCategory"]).to eq("Expedited")
      expect(JSON.parse(fba_outbound_client.get_fulfillment_preview(address,items).body).dig("payload", "fulfillmentPreviews")[1]["shippingSpeedCategory"]).to eq("Priority")
      expect(JSON.parse(fba_outbound_client.get_fulfillment_preview(address,items).body).dig("payload", "fulfillmentPreviews")[2]["shippingSpeedCategory"]).to eq("Standard")
    end    
  end

  describe "get_fulfillment_preview" do
    before { stub_get_outbound_fulfillment_preview }
    
    it "makes a request to get list fulfillment orders" do
      expect(fba_outbound_client.get_fulfillment_preview(address,items).response_code).to eq(200)
      expect(JSON.parse(fba_outbound_client.get_fulfillment_preview(address,items).body).dig("payload", "fulfillmentPreviews").first["shippingSpeedCategory"]).to eq("Expedited")
      expect(JSON.parse(fba_outbound_client.get_fulfillment_preview(address,items).body).dig("payload", "fulfillmentPreviews")[1]["shippingSpeedCategory"]).to eq("Priority")
      expect(JSON.parse(fba_outbound_client.get_fulfillment_preview(address,items).body).dig("payload", "fulfillmentPreviews")[2]["shippingSpeedCategory"]).to eq("Standard")
    end    
  end

  context "list_fulfillment_orders" do
    describe "list_fulfillment_orders" do
      before { stub_list_fulfillment_orders }

      it "makes a request to get list fulfillment orders" do
        expect(fba_outbound_client.list_fulfillment_orders(nil,nil).response_code).to eq(200)
        expect(JSON.parse(fba_outbound_client.list_fulfillment_orders.body).dig("payload", "fulfillmentOrders").first["sellerFulfillmentOrderId"]).to eq(seller_fulfillment_order_id)
      end
    end

    describe "list_fulfillment_orders with start date and token" do
      before { stub_list_fulfillment_orders_with_date_token(query_start_date, next_token) }

      it "makes a request to get list fulfillment orders" do
        expect(fba_outbound_client.list_fulfillment_orders(query_start_date,next_token).response_code).to eq(200)
        expect(JSON.parse(fba_outbound_client.list_fulfillment_orders(query_start_date,next_token).body).dig("payload", "fulfillmentOrders").first["sellerFulfillmentOrderId"]).to eq(seller_fulfillment_order_id)
      end
    end
  end

  describe "get_fulfillment_order" do
    before { stub_get_fulfillment_order(seller_fulfillment_order_id) }

    it "makes a request to get fulfillment order" do
      expect(fba_outbound_client.get_fulfillment_order(seller_fulfillment_order_id).response_code).to eq(200)
      expect(JSON.parse(fba_outbound_client.get_fulfillment_order(seller_fulfillment_order_id).body).dig("payload", "fulfillmentOrders").first["sellerFulfillmentOrderId"]).to eq(seller_fulfillment_order_id)
    end
  end

  describe "cancel_fulfillment_order" do
    before { stub_cancel_fulfillment_order(seller_fulfillment_order_id) }

    it "makes a request to get fulfillment order" do
      expect(fba_outbound_client.cancel_fulfillment_order(seller_fulfillment_order_id).response_code).to eq(200)
    end
  end
end