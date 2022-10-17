require "muffin_man/request_helpers/outbound_fulfillment/address"
require "muffin_man/request_helpers/outbound_fulfillment/item"
require "muffin_man/request_helpers/outbound_fulfillment/fulfillment_preview_request"
require "muffin_man/request_helpers/outbound_fulfillment/fulfillment_order_request"

RSpec.describe MuffinMan::FulfillmentOutbound::V20200701 do
  before do
    stub_request_access_token
  end

  let(:country_code) { "US" }
  let(:query_start_date) {"2020-10-10"}
  let(:next_token) {"token"}
  let(:seller_fulfillment_order_id) {"19-XXXXX-50736"}

  let(:address) do
    MuffinMan::RequestHelpers::OutboundFulfillment::Address.new({
      "name"=>"The Muffin Man",
      "address_line1"=>"12345 Drury Lane",
      "address_line2"=>nil,
      "city"=>"CandyLand",
      "district_or_county"=>nil,
      "state_or_region"=>"CL",
      "country_code"=>"US",
      "postal_code"=>"12345"
    })
  end

  let(:items) do
    [
      MuffinMan::RequestHelpers::OutboundFulfillment::Item.new({
              "seller_sku"=>"SD-P4L-104525",
              "seller_fulfillment_order_item_id"=>"10048980045217",
              "quantity"=>1
            })
    ]
  end

  subject(:fba_outbound_client) { described_class.new(credentials) }

  describe "get_fulfillment_preview" do
    before { stub_get_outbound_fulfillment_preview }
    let(:fulfillment_preview_request) do
      MuffinMan::RequestHelpers::OutboundFulfillment::FulfillmentPreviewRequest.new(address,items)
    end

    it "makes a request to get outbound fulfillment preview" do
      response = fba_outbound_client.get_fulfillment_preview(fulfillment_preview_request)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body).dig("payload", "fulfillmentPreviews").first["shippingSpeedCategory"]).to eq("Expedited")
      expect(JSON.parse(response.body).dig("payload", "fulfillmentPreviews")[1]["shippingSpeedCategory"]).to eq("Priority")
      expect(JSON.parse(response.body).dig("payload", "fulfillmentPreviews")[2]["shippingSpeedCategory"]).to eq("Standard")
    end
  end

  describe "create_fulfillment_orders" do
    before { stub_create_fulfillment_orders }

    let(:fulfillment_order) do
      MuffinMan::RequestHelpers::OutboundFulfillment::FulfillmentOrderRequest.new("seller_fulfillment_order_id",
        "displayable_order_id",
        "displayable_order_date_time",
        "displayable_order_comment",
        "shipping_speed_category",
        address,
        items)
    end
    
    it "makes a request to create outbound fulfillment order" do
      response = fba_outbound_client.create_fulfillment_orders(fulfillment_order)
      expect(response.response_code).to eq(200)
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