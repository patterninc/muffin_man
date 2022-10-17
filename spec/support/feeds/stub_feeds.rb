def stub_get_feeds
  stub_request(:get, "https://#{hostname}/feeds/2021-06-30/feeds?feedTypes=#{feed_types}&marketplaceIds=#{amazon_marketplace_ids}")
    .to_return(status: 200, body: File.read("./spec/support/feeds/get_feeds.json"), headers: {})
end

def stub_get_feed
  stub_request(:get, "https://#{hostname}/feeds/2021-06-30/feeds/#{feed_id}")
    .to_return(status: 200, body: JSON.parse(File.read("./spec/support/feeds/get_feeds.json"))["feeds"].first.to_json, headers: {})
end

def stub_create_feed
  stub_request(:post, "https://#{hostname}/feeds/2021-06-30/feeds").with(body: {"feedType": feed_types, "marketplaceIds": amazon_marketplace_ids, "inputFeedDocumentId": feed_document_id})
    .to_return(status: 202, body: {feedId: feed_id}.to_json, headers: {})
end

def stub_create_documents
  stub_request(:post, "https://#{hostname}/feeds/2021-06-30/documents").with(body: {"contentType": content_type})
    .to_return(status: 201, body: File.read("./spec/support/feeds/create_documents.json"), headers: {})
end

def stub_get_document
  stub_request(:get, "https://#{hostname}/feeds/2021-06-30/documents/#{feed_document_id}")
    .to_return(status: 200, body: File.read("./spec/support/feeds/create_documents.json"), headers: {})
end

def stub_next_token_get_feeds
  stub_request(:get, "https://#{hostname}/feeds/2021-06-30/feeds?nextToken=#{next_token}")
    .to_return(status: 200, body: File.read("./spec/support/feeds/get_feeds.json"), headers: {})
end
