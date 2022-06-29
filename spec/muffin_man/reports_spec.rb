RSpec.describe MuffinMan::Reports::V20210630 do
  before do
    stub_request_access_token
    stub_get_reports
    stub_create_report
    stub_get_report
    stub_cancel_report
    stub_get_report_document
    stub_report_document_contents
  end
  let(:report_types) { "FEE_DISCOUNTS_REPORT,GET_AFN_INVENTORY_DATA" }
  let(:processing_statuses) { "IN_QUEUE,IN_PROGRESS" }
  let(:amazon_marketplace_id) { "ATVPDKIKX0DER" }
  let(:report_type) { "_BLUEBERRY_VS_POPPYSEED_" }
  let(:start_time) { Time.now - 3600 }
  let(:end_time) { Time.now }
  let(:report_id) { "ID323" }
  let(:report_document_id) { "0356cf79-b8b0-4226-b4b9-0ee058ea5760" }

  subject(:reports_client) { described_class.new(credentials) }

  describe "get_reports" do
    it "requests a list of reports" do
      response = reports_client.get_reports("reportTypes" => report_types, "processingStatuses" => processing_statuses)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["reports"][0]["reportId"]).to eq("ReportId1")
    end
  end

  describe "create_report" do
    it "requests that a report be created" do
      response = reports_client.create_report(report_type, amazon_marketplace_id, start_time, end_time)
      expect(response.response_code).to eq(201)
      expect(JSON.parse(response.body)["reportId"]).not_to be_nil
    end
  end

  describe "get_report" do
    it "requests a report" do
      response = reports_client.get_report(report_id)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["reportId"]).to eq("ReportId1")
    end
  end

  describe "cancel_report" do
    it "cancels a report" do
      response = reports_client.cancel_report(report_id)
      expect(response.response_code).to eq(200)
    end
  end

  describe "get_report_document" do
    it "requests a report document" do
      response = reports_client.get_report_document(report_document_id)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["url"]).to eq("https://d34o8swod1owfl.cloudfront.net/Report_47700__GET_MERCHANT_LISTINGS_ALL_DATA_.txt")
    end
  end

  describe "get_report_document_body" do
    it "requests a report document" do
      report = reports_client.get_report_document_body(report_document_id)
      expect(report).to eq(File.read("./spec/support/report_document_contents.txt"))
    end
  end
end
