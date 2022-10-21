# frozen_string_literal: true

module Support
  module SpApiHelpers
    def stub_request_access_token
      stub_request(:post, "https://api.amazon.com/auth/o2/token")
        .with(body: { "grant_type" => "refresh_token",
                      "refresh_token" => "a-refresh-token",
                      "client_id" => "a-client-id",
                      "client_secret" => "a-client-secret" }.to_json,
              headers: { "Content-Type" => "application/x-www-form-urlencoded;charset=UTF-8", "Expect" => "",
                         "User-Agent" => "" })
        .to_return(status: 200, body: '{ "access_token": "this_will_get_you_into_drury_lane", "expires_in": 3600 }',
                   headers: {})
    end

    def stub_fake_request
      stub_request(:get, "https://#{hostname}/some_path")
        .to_return(status: 200, body: "{}", headers: {})
    end

    def stub_create_report
      stub_request(:post, "https://#{hostname}/reports/2021-06-30/reports")
        .with(
          body: {
            "reportType" => report_type,
            "marketplaceIds" => amazon_marketplace_id,
            "dataStartTime" => start_time,
            "dataEndTime" => end_time
          }.to_json
        )
        .to_return(status: 201, body: { "reportId": "ID323" }.to_json, headers: {})
    end

    def stub_solicitations
      stub_request(:post, "https://#{hostname}/solicitations/v1/orders/#{amazon_order_id}/solicitations/productReviewAndSellerFeedback?marketplaceIds=#{amazon_marketplace_id}")
        .to_return(status: 201, body: "{}", headers: {})
    end

    def stub_get_catalog_item
      stub_request(:get, "https://#{hostname}/catalog/2020-12-01/items/#{asin}?marketplaceIds=#{amazon_marketplace_id}")
        .to_return(status: 200, body: File.read("./spec/support/get_catalog_item.json"), headers: {})
    end

    def stub_search_catalog_items
      stub_request(:get, "https://#{hostname}/catalog/2020-12-01/items?keywords=#{keywords}&marketplaceIds=#{amazon_marketplace_id}")
        .to_return(status: 200, body: File.read("./spec/support/search_catalog_items.json"), headers: {})
    end

    def credentials
      {
        refresh_token: "a-refresh-token",
        client_id: "a-client-id",
        client_secret: "a-client-secret",
        aws_access_key_id: "an-aws-access-key-id",
        aws_secret_access_key: "an-aws-secret-access-key"
      }
    end

    def hostname
      "sellingpartnerapi-na.amazon.com"
    end
  end
end
