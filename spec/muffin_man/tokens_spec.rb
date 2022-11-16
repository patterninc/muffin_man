RSpec.describe MuffinMan::Tokens::V20210301 do
  before do
    stub_request_access_token
    stub_request_rdt_token
  end

  let(:selling_partner_id) { "TheMuffinMan" }
  let(:developer_id) { "WhoLivesOnDruryLane" }
  let(:mws_auth_token) { "Yes,IKnowTheMuffinMan" }

  subject(:client) { described_class.new(credentials) }

  describe "create_restricted_data_token" do
    it "gets a token" do
      response = client.create_restricted_data_token(selling_partner_id, developer_id, mws_auth_token)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["restrictedDataToken"]).to eq("this_will_get_you_into 123 E. drury_lane")
    end
  end
end
