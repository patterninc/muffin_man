RSpec.describe MuffinMan::Lwa::AuthHelper do
  before do
    stub_request_refresh_token
    stub_request_bad_refresh_token
  end

  let(:client_id) { "test_client_id" }
  let(:client_secret) { "test_client_secret" }
  let(:auth_code) { "test_auth_code" }
  let(:bad_auth_code) { "bad_auth_code" }

  describe "get_refresh_token" do
    it "gets a refresh token from lwa using an authorization code" do
      refresh_token = described_class.get_refresh_token(client_id, client_secret, auth_code)
      expect(refresh_token).to eq("good_refresh_token")
    end

    it "raises an error if the authorization code is invalid" do
      expect { described_class.get_refresh_token(client_id, client_secret, bad_auth_code) }.to raise_error(MuffinMan::Error)
    end
  end
end
