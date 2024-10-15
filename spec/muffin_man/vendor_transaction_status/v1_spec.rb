RSpec.describe MuffinMan::VendorTransactionStatus::V1 do
  subject(:vendor_transaction_status_client) { described_class.new(credentials) }

  before do
    stub_request_access_token
  end

  describe "get_transaction" do
    let(:transaction_id) { "20190904190535-eef8cad8-418e-4ed3-ac72-789e2ee6214a" }

    it "executes get_transaction request" do
      stub_vendor_transaction_status_v1_get_transaction
      response = vendor_transaction_status_client.get_transaction(transaction_id)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)).to include(
        "payload" => {
          "transactionStatus" => {
            "transactionId" => transaction_id,
            "status" => be_present
          }
        }
      )
    end
  end
end
