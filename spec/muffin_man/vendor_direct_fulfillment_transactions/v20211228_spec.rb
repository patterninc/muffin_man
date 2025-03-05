# frozen_string_literal: true

RSpec.describe MuffinMan::VendorDirectFulfillmentTransactions::V20211228 do
  subject(:vendor_direct_fulfillment_transactions_client) { described_class.new(credentials) }

  before do
    stub_request_access_token
  end

  describe "get_transaction_status" do
    let(:transaction_id) { "20190918190535-eef8cad8-418e-456f-ac72-789e2ee6813c" }

    it "executes get_transaction_status request" do
      stub_vendor_direct_fulfillment_transactions_v20211228_get_transaction_status
      response = vendor_direct_fulfillment_transactions_client.get_transaction_status(transaction_id)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)).to include(
        "transactionId" => transaction_id,
        "status" => be_present
      )
    end
  end
end
