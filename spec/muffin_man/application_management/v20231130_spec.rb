# frozen_string_literal: true

RSpec.describe MuffinMan::ApplicationManagement::V20231130 do
  let(:access_token) { "test_access_token" }
  let(:client_id) { "test_client_id" }
  let(:client_secret) { "test_client_secret" }
  let(:new_app_credential_url) { "https://sellingpartnerapi-na.amazon.com/applications/2023-11-30/clientSecret" }

  describe ".rotate_application_client_secret" do
    let(:response) { instance_double(Typhoeus::Response) }

    before do
      allow(MuffinMan::Lwa::AuthHelper).to receive(:get_access_token)
        .with("sellingpartnerapi::client_credential:rotation", client_id, client_secret)
        .and_return(access_token)

      allow(Typhoeus).to receive(:post).and_return(response)
    end

    context "when the request is successful (204)" do
      before do
        allow(response).to receive(:code).and_return(204)
        allow(response).to receive(:body).and_return("")
      end

      it "returns the response and makes the correct API call" do
        expect(Typhoeus).to receive(:post).with(
          new_app_credential_url,
          headers: {
            "x-amz-access-token" => access_token,
            "Content-Type" => "application/json;charset=UTF-8"
          }
        )

        result = described_class.rotate_application_client_secret(client_id, client_secret)
        expect(result).to eq(response)
      end
    end
  end
end
