# frozen_string_literal: true

RSpec.describe MuffinMan::Uploads::V20201101 do
  subject(:uploads_client) { described_class.new(credentials) }  
  before do
    stub_request_access_token
    stub_upload_destination(resource_path, marketplace_id, content_md5, content_type)
  end
  
  let(:content_md5) { "123-1234567-1234567" }
  let(:marketplace_id) { ["ATVPDKIKX0DER"] }
  let(:resource_path) { "aplus/2020-11-01/contentDocuments" }
  let(:content_type) { "image/jpeg" }

  describe "create_upload_destination_for_resource" do
    it "makes a create_upload_destination_for_resource request to amazon" do
      expect(uploads_client.create_upload_destination_for_resource(marketplace_id, resource_path, content_md5, content_type).response_code).to eq(201)
    end
  end
end
