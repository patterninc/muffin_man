# frozen_string_literal: true

def stub_create_content_documents
  stub_request(:post, "https://#{hostname}/aplus/2020-11-01/contentDocuments")
    .with(body: content_document_payload.to_json, query: { marketplaceId: marketplace_id })
    .to_return(status: 200, headers: {})
end

def stub_post_content_document_asin_relations
  stub_request(:post, "https://#{hostname}/aplus/2020-11-01/contentDocuments/#{content_reference_key}/asins")
    .with(body: { asinSet: asin_set }.to_json, query: { marketplaceId: marketplace_id })
    .to_return(status: 200, headers: {})
end

def stub_post_content_document_approval_submission
  stub_request(:post, "https://#{hostname}/aplus/2020-11-01/contentDocuments/#{content_reference_key}/approvalSubmissions")
    .with(query: { marketplaceId: marketplace_id }) { |request| request.body.blank? }
    .to_return(status: 200, headers: {})
end

def stub_validate_content_document_asin
  stub_request(:post, "https://#{hostname}/aplus/2020-11-01/contentAsinValidations")
    .with(body: content_document_payload.to_json, query: { marketplaceId: marketplace_id,
                                                           asinSet: asin_set.join(",") })
    .to_return(status: 200, headers: {})
end

def stub_create_media
  stub_request(:post, "https://#{hostname}/aplus/2020-11-01/media")
    .with(body: create_media_request.to_json) { |request| request.uri.query.nil? }
    .to_return(status: 201, headers: {}, body: { mediaId: video_media_id, mediaType: "VIDEO" }.to_json)
end

def stub_get_media
  stub_request(:get, "https://#{hostname}/aplus/2020-11-01/media/#{video_media_id}")
    .with { |request| request.body.blank? }
    .to_return(status: 200, headers: {}, body: { mediaId: video_media_id, status: ["AVAILABLE"] }.to_json)
end

def stub_get_media_for_pairing
  stub_request(:get, "https://#{hostname}/aplus/2020-11-01/media/#{video_media_id}")
    .with(query: { associatedMediaId: image_media_id })
    .to_return(status: 200, headers: {})
end
