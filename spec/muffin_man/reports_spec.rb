RSpec.describe MuffinMan::Reports::V20210630 do
  before do
    stub_request_access_token
    stub_create_report
  end
  let(:amazon_marketplace_id) { "ATVPDKIKX0DER" }
  let(:report_type) { '_BLUEBERRY_VS_POPPYSEED_' }
  let(:start_time) { Time.now - 3600 }
  let(:end_time) { Time.now }

  subject(:reports_client) { described_class.new(credentials) }

  describe "create_report" do
    it 'requests that a report be created' do
      response = reports_client.create_report(report_type, amazon_marketplace_id, start_time, end_time)
      expect(response.response_code).to eq(201)
      expect(JSON.parse(response.body)["reportId"]).not_to be_nil
    end
  end
end
