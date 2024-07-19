# frozen_string_literal: true

RSpec.describe MuffinMan::DataKiosk::V20231115 do
  subject(:data_kiosk_client) { described_class.new(credentials) }

  let(:query_id) { "QueryId1" }

  before do
    stub_request_access_token
  end

  describe "get_queries" do
    it "executes get_queries request" do
      stub_get_queries
      response = data_kiosk_client.get_queries
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["queries"]).not_to be_nil
    end
  end

  describe "create_query" do
    let(:query) do
      <<-QUERY
      query {
        sampleQuery(
          startDate: "2023-03-01"
          endDate: "2023-03-31"
          marketplaceIds: ["ATVPDKIKX0DER"]
        ) {
          sales {
            date
            averageSellingPrice {
              amount
              currencyCode
            }
          }
        }
      }
      QUERY
    end

    it "executes create_query request" do
      stub_create_query
      response = data_kiosk_client.create_query(query)
      expect(response.response_code).to eq(202)
      expect(JSON.parse(response.body)["queryId"]).to eq query_id
    end
  end

  describe "get_query" do
    it "executes get_query request" do
      stub_get_query
      response = data_kiosk_client.get_query(query_id)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["queryId"]).to eq query_id
    end
  end

  describe "cancel_query" do
    it "executes cancel_query request" do
      stub_cancel_query
      response = data_kiosk_client.cancel_query(query_id)
      expect(response.response_code).to eq(204)
    end
  end

  describe "get_document" do
    let(:document_id) { "DocumentId1" }

    it "executes get_document request" do
      stub_get_document
      response = data_kiosk_client.get_document(document_id)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["documentId"]).to eq document_id
    end
  end
end
