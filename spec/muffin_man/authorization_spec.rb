RSpec.describe MuffinMan::Authorization::V1 do
  before do
    stub_request_access_token
    stub_get_authorization_code
  end
  let(:selling_partner_id) { "SELLINGID" }
  let(:developer_id) { "DEVID" }
  let(:mws_auth_token) { "MWSTOKEN" }

  subject(:authorization_client) { described_class.new(credentials) }

  describe "get_authorization_code" do
    it "requests an authorization code" do
      response = authorization_client.get_authorization_code(selling_partner_id, developer_id, mws_auth_token)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["payload"]["authorizationCode"]).to eq("ANDMxqpCmqWHJeyzdbMH")
    end
  end
end
