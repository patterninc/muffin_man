RSpec.describe MuffinMan::Orders::V20260101 do
  subject(:orders_client) { described_class.new(credentials) }

  before { stub_request_access_token }

  describe "#search_orders" do
    it "returns orders" do
      stub_request(:get, "https://#{hostname}/orders/2026-01-01/orders")
        .to_return(status: 200, body: File.read("./spec/support/orders/v20260101_search_orders.json"))

      response = orders_client.search_orders

      expect(response).to be_success
      expect(JSON.parse(response.body)["orders"]).to be_an(Array)
    end
  end

  describe "#get_order" do
    it "returns the order" do
      order_id = "202-1234567-8901234"

      stub_request(:get, "https://#{hostname}/orders/2026-01-01/orders/#{order_id}")
        .to_return(status: 200, body: File.read("./spec/support/orders/v20260101_get_order.json"))

      response = orders_client.get_order(order_id)

      expect(response).to be_success
      expect(JSON.parse(response.body).dig("order", "orderId")).to eq(order_id)
    end
  end
end
