# frozen_string_literal: true

def stub_upload_destination(resource_path, marketplace_id, content_md5, content_type)
  stub_request(:post, "https://#{hostname}/uploads/2020-11-01/uploadDestinations/#{resource_path}")
    .with(query: { marketplaceIds: marketplace_id, contentMD5: content_md5, contentType: content_type })
    .to_return(status: 201, body: { "payload": {"uploadDestinationId": "upload-id", "url": "https://aplus-media.s3.amazonaws.com/upload-id"} }.to_json, headers: {})
end
