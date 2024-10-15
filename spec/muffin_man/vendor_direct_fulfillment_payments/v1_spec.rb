RSpec.describe MuffinMan::VendorDirectFulfillmentPayments::V1 do
  subject(:vendor_direct_fulfillment_payments_client) { described_class.new(credentials) }

  before do
    stub_request_access_token
  end

  describe "submit_invoice" do
    let(:invoices) do
      [
        {
          "invoiceNumber" => "0092590411",
          "invoiceDate" => "2020-03-13T11:16:24Z",
          "remitToParty" => {
            "partyId" => "YourVendorCode"
          },
          "shipFromParty" => {
            "partyId" => "ABCD"
          },
          "invoiceTotal" => {
            "currencyCode" => "EUR",
            "amount" => "1428.00"
          },
          "items" => [
            {
              "itemSequenceNumber" => "1",
              "invoicedQuantity" => {
                "amount" => 1,
                "unitOfMeasure" => "Each"
              },
              "netCost" => {
                "currencyCode" => "EUR",
                "amount" => "1200.00"
              },
              "purchaseOrderNumber" => "D3rC3KTxG"
            }
          ]
        }
      ]
    end
    let(:transaction_id) { "20190905010908-8a3b6901-ef20-412f-9270-21c021796605" }

    it "executes submit_invoice request" do
      stub_vendor_direct_fulfillment_payments_v1_submit_invoice
      response = vendor_direct_fulfillment_payments_client.submit_invoice(invoices)
      expect(response.response_code).to eq(202)
      expect(JSON.parse(response.body)["transactionId"]).to eq transaction_id
    end
  end
end
