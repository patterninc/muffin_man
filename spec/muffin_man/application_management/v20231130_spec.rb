# frozen_string_literal: true

require "spec_helper"
require "typhoeus"
require "muffin_man/application_management/v20231130"

RSpec.describe MuffinMan::ApplicationManagement::V20231130 do
  let(:access_token) { "test_access_token" }
  let(:new_app_credential_url) { "https://sellingpartnerapi-na.amazon.com/applications/2023-11-30/clientSecret" }

  describe ".create_new_credentials" do
    let(:response) { instance_double(Typhoeus::Response) }

    before do
      allow(Typhoeus).to receive(:post).and_return(response)
    end

    context "when the request is successful (204)" do
      before do
        allow(response).to receive(:code).and_return(204)
        allow(response).to receive(:body).and_return("")
      end

      it "returns the response" do
        result = described_class.create_new_credentials(access_token)
        expect(result).to eq(response)
        expect(Typhoeus).to have_received(:post).with(
          new_app_credential_url,
          headers: { "x-amz-access-token" => access_token }
        )
      end
    end

    context "when the request fails" do
      let(:error_body) do
        {
          "error" => "InvalidToken",
          "error_description" => "The provided token is invalid."
        }.to_json
      end

      before do
        allow(response).to receive(:code).and_return(401)
        allow(response).to receive(:body).and_return(error_body)
      end

      it "raises a MuffinMan::Error with the error details" do
        expect do
          described_class.create_new_credentials(access_token)
        end.to raise_error(MuffinMan::Error, "InvalidToken: The provided token is invalid. ")
      end
    end
  end
end
