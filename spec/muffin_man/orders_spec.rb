RSpec.describe MuffinMan::Orders::V0 do
  # before do
  #   stub_request_access_token
  # end

  let(:marketplace_ids) { ["ATVPDKIKX0DER"] } 
  let(:processing_statuses) { "IN_QUEUE,IN_PROGRESS" }
  let(:start_time) { Time.now - 3600 }
  let(:end_time) { Time.now }
  let(:order_id) { "ID323" }

  subject(:orders_client) { described_class.new(credentials) }

  describe "get_orders" do
    it "requests a list of orders" do
      WebMock.allow_net_connect!
      response = orders_client.get_orders(marketplace_ids:marketplace_ids)
      puts "#{response}"
      expect(response.response_code).to eq(200)
    end
  end
end