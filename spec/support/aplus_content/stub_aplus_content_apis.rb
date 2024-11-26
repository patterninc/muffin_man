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

def stub_validate_content_document_asin
  stub_request(:post, "https://#{hostname}/aplus/2020-11-01/contentAsinValidations")
    .with(body: content_document_payload.to_json, query: { marketplaceId: marketplace_id,
                                                           asinSet: asin_set.join(",") })
    .to_return(status: 200, headers: {})
end
