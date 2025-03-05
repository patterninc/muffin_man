# frozen_string_literal: true

RSpec.describe MuffinMan::VendorInvoices::V1 do
  subject(:vendor_invoices_client) { described_class.new(credentials) }

  before do
    stub_request_access_token
  end

  describe "submit_invoices" do
    let(:invoices) do
      [
        {
          "id" => "TestInvoice202",
          "date" => "2020-06-08T12:00:00.000Z",
          "billToParty" => {
            "partyId" => "TES1"
          },
          "invoiceType" => "Invoice",
          "remitToParty" => {
            "partyId" => "ABCDE"
          },
          "invoiceTotal" => {
            "amount" => "112.05",
            "currencyCode" => "USD"
          }
        }
      ]
    end
    let(:payload) { { "transactionId" => "20190904171225-e1275c33-d75b-4bfe-b95c-15a9abfc09cc" } }

    it "executes submit_invoices request" do
      stub_vendor_invoices_v1_submit_invoices
      response = vendor_invoices_client.submit_invoices(invoices)
      expect(response.response_code).to eq(202)
      expect(JSON.parse(response.body)["payload"]).to eq payload
    end
  end
end
