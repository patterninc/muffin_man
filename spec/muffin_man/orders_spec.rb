RSpec.describe MuffinMan::Orders::V0 do
  before do
    stub_request_access_token
    stub_get_orders
    stub_get_orders_with_ids
    stub_get_orders_with_next_token
    stub_get_order_items
  end

  let(:marketplace_ids) { "ATVPDKIKX0DER,A2EUQ1WTGCTBG2" } 
  let(:order_id) { "ID323" }
  let(:payload) { {"orderIds"=>"123-1234567-1234567,123-2345678-2345678"} }
  let(:payload_2) { {"NextToken"=>"12345678901234567890"} }

  subject(:orders_client) { described_class.new(credentials) }

  describe "get_orders" do
    it "requests a list of orders" do
      response = orders_client.get_orders(marketplace_ids)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["payload"]["Orders"][0]["AmazonOrderId"]).to eq("ORDER_ID_1")
    end

    it "requests a list of orders given list of order_ids" do
      response = orders_client.get_orders(marketplace_ids, payload)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["payload"]["Orders"][0]["AmazonOrderId"]).to eq("ORDER_ID_1")
    end

    it "requests a list of orders given a next token" do
      response = orders_client.get_orders(marketplace_ids, payload_2)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["payload"]["Orders"][0]["AmazonOrderId"]).to eq("ORDER_ID_1")
    end
  end

  describe "get_order_items" do
    it "requests a list of orders" do
      response = orders_client.get_order_items(order_id)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["payload"]["OrderItems"][0]["ASIN"]).to eq("B07QLFMYWM")
    end
  end
end
