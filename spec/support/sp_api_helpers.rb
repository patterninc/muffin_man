require './spec/support/feeds/stub_feeds'
require './spec/support/notifications/stub_notifications'

module Support
  module SpApiHelpers
    def stub_request_access_token
      stub_request(:post, "https://api.amazon.com/auth/o2/token")
        .with(body: "grant_type=refresh_token&refresh_token=a-refresh-token&client_id=a-client-id&client_secret=a-client-secret",
              headers: { "Content-Type" => "application/x-www-form-urlencoded;charset=UTF-8", "Expect" => "",
                         "User-Agent" => "" })
        .to_return(status: 200, body: '{ "access_token": "this_will_get_you_into_drury_lane", "expires_in": 3600 }', headers: {})
    end

    def stub_request_grantless_access_token
      body = {
        grant_type: "client_credentials",
        scope: scope,
        client_id: "a-client-id",
        client_secret: "a-client-secret"
      }
      stub_request(:post, "https://api.amazon.com/auth/o2/token")
        .with(body: URI.encode_www_form(body),
              headers: { "Content-Type" => "application/x-www-form-urlencoded;charset=UTF-8" })
        .to_return(status: 200, body: '{ "access_token": "this_will_get_you_into_drury_lane", "expires_in": 3600 }', headers: {})
    end

    def stub_request_rdt_token
      stub_request(:post, "https://#{hostname}/tokens/2021-03-01/restrictedDataToken")
        .with(body: hash_including({ "restrictedResources" => hash_including({})}))
        .to_return(status: 200, body: '{ "restrictedDataToken": "this_will_get_you_into 123 E. drury_lane", "expires_in": 3600 }', headers: {})
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

    def stub_get_catalog_item_v20220401
      stub_request(:get, "https://#{hostname}/catalog/2022-04-01/items/#{asin}?marketplaceIds=#{amazon_marketplace_id}")
        .to_return(status: 200, body: File.read("./spec/support/get_catalog_item_v20220401.json"), headers: {})
    end

    def stub_search_catalog_items_v20220401
      stub_request(:get, "https://#{hostname}/catalog/2022-04-01/items?keywords=#{keywords}&marketplaceIds=#{amazon_marketplace_id}")
        .to_return(status: 200, body: File.read("./spec/support/search_catalog_items_v20220401.json"), headers: {})
    end

    def stub_list_financial_event_groups
      stub_request(:get, "https://#{hostname}/finances/v0/financialEventGroups")
        .with(
          query: {
            MaxResultsPerPage: max_results_per_page,
            FinancialEventGroupStartedBefore: financial_event_group_started_before,
            FinancialEventGroupStartedAfter: financial_event_group_started_after
          }
        )
        .to_return(status: 200, body: File.read("./spec/support/list_financial_event_groups.json"), headers: {})
    end

    def stub_list_financial_event_by_group_id
      stub_request(:get, "https://#{hostname}/finances/v0/financialEventGroups/#{event_group_id}/financialEvents")
        .with(
          query: {
            MaxResultsPerPage: max_results_per_page,
            PostedBefore: posted_before,
            PostedAfter: posted_after
          }
        )
        .to_return(status: 200, body: File.read("./spec/support/list_financial_event_groups.json"), headers: {})
    end

    def stub_get_reports
      stub_request(:get, "https://#{hostname}/reports/2021-06-30/reports?processingStatuses=#{processing_statuses}&reportTypes=#{report_types}")
        .to_return(status: 200, body: File.read("./spec/support/get_reports.json"), headers: {})
    end

    def stub_get_report
      stub_request(:get, "https://#{hostname}/reports/2021-06-30/reports/#{report_id}")
        .to_return(status: 200, body: File.read("./spec/support/get_report.json"), headers: {})
    end

    def stub_cancel_report
      stub_request(:delete, "https://#{hostname}/reports/2021-06-30/reports/#{report_id}")
        .to_return(status: 200, headers: {})
    end

    def stub_get_report_document
      stub_request(:get, "https://#{hostname}/reports/2021-06-30/documents/#{report_document_id}")
        .to_return(status: 200, body: File.read("./spec/support/get_report_document.json"), headers: {})
    end

    def stub_report_document_contents
      stub_request(:get, "https://d34o8swod1owfl.cloudfront.net/Report_47700__GET_MERCHANT_LISTINGS_ALL_DATA_.txt").
        to_return(status: 200, body: File.read("./spec/support/report_document_contents.txt"), headers: { 'Content-Type' => 'text/tsv' })
    end


    def stub_get_orders
      stub_request(:get, "https://#{hostname}/orders/v0/orders?MarketplaceIds=#{marketplace_ids}")
        .to_return(status: 200, body: File.read("./spec/support/get_orders.json"), headers: {})
    end

    def stub_get_orders_with_ids
      stub_request(:get, "https://#{hostname}/orders/v0/orders?MarketplaceIds=#{marketplace_ids}&AmazonOrderIds=#{payload["orderIds"]}")
        .to_return(status: 200, body: File.read("./spec/support/get_orders.json"), headers: {})
    end

    def stub_get_orders_with_next_token
      stub_request(:get, "https://#{hostname}/orders/v0/orders?MarketplaceIds=#{marketplace_ids}&NextToken=#{payload_2["NextToken"]}")
      .to_return(status: 200, body: File.read("./spec/support/get_orders.json"), headers: {})
    end

    def stub_get_order_items
      stub_request(:get, "https://#{hostname}/orders/v0/orders/#{order_id}/orderItems")
        .to_return(status: 200, body: File.read("./spec/support/get_order_items.json"), headers: {})
    end

    def stub_get_order_address
      stub_request(:get, "https://#{hostname}/orders/v0/orders/#{order_id}/address")
        .to_return(status: 200, body: File.read("./spec/support/get_order_address.json"), headers: {})
    end

    def stub_get_authorization_code
      body = '{"payload":{"authorizationCode": "ANDMxqpCmqWHJeyzdbMH"}}'
      stub_request(:get, "https://#{hostname}/authorization/v1/authorizationCode?developerId=#{developer_id}&mwsAuthToken=#{mws_auth_token}&sellingPartnerId=#{selling_partner_id}")
        .to_return(status: 200, body: body, headers: {})
    end

    def stub_get_my_fees_estimate_for_asin
      stub_request(:post, "https://#{hostname}/products/fees/v0/items/#{asin}/feesEstimate")
        .to_return(status: 200, body: File.read("./spec/support/get_fees_estimate.json"), headers: {})
    end

    def stub_get_competitive_pricing
      stub_request(:get, "https://#{hostname}/products/pricing/v0/competitivePrice?Asins=#{asin}&ItemType=#{item_type}&MarketplaceId=#{amazon_marketplace_id}")
        .to_return(status: 200, body: File.read("./spec/support/get_competitive_pricing.json"), headers: {})
    end

    def stub_get_listings_item
      stub_request(:get, "https://#{hostname}/listings/2021-08-01/items/#{seller_id}/#{sku}?marketplaceIds=#{amazon_marketplace_id}")
        .to_return(status: 200, body: File.read("./spec/support/get_listings_item.json"), headers: {})
    end

    def stub_get_prep_instructions
      stub_request(:get, "https://#{hostname}/fba/inbound/v0/prepInstructions?ShipToCountryCode=#{country_code}&SellerSKUList=#{sku_list.join(",")}")
        .to_return(status: 200, body: File.read("./spec/support/get_prep_instructions.json"), headers: {})
    end

    def stub_create_inbound_shipment_plan
      stub_request(:post, "https://#{hostname}/fba/inbound/v0/plans")
        .to_return(status: 200, body: File.read("./spec/support/create_inbound_shipment_plan_v0.json"), headers: {})
    end

    def stub_create_inbound_shipment
      stub_request(:post, "https://#{hostname}/fba/inbound/v0/shipments/#{shipment_id}")
        .to_return(status: 200, body: File.read("./spec/support/create_inbound_shipment_v0.json"), headers: {})
    end

    def stub_put_transport_details
      stub_request(:put, "https://sellingpartnerapi-na.amazon.com/fba/inbound/v0/shipments/#{shipment_id}/transport").
         with(:body => "{\"shipmentId\":\"FBA1232453KJ\",\"IsPartnered\":true,\"ShipmentType\":\"LPL\",\"TransportDetails\":[{\"PartneredSmallParcelData\":[],\"NonPartneredSmallParcelData\":[],\"PartneredLtlData\":[],\"NonPartneredLtlData\":[]}]}").
         to_return(:status => 200, :body => File.read("./spec/support/put_transport_details_v0.json"), :headers => {})
    end

    def stub_get_shipments
      stub_request(:get, "https://#{hostname}/fba/inbound/v0/shipments?MarketplaceId=#{marketplace_id}&QueryType=#{query_type}&ShipmentIdList=#{shipment_id_list.join(",")}")
        .to_return(status: 200, body: File.read("./spec/support/get_shipments_v0.json"), headers: {})
    end

    def stub_update_inbound_shipment
      stub_request(:put, "https://#{hostname}/fba/inbound/v0/shipments/#{shipment_id}")
        .to_return(status: 200, body: File.read("./spec/support/update_inbound_shipment_v0.json"), headers: {})
    end

    def stub_get_labels
      stub_request(:get, "https://sellingpartnerapi-na.amazon.com/fba/inbound/v0/shipments/FBA1232453KJ/labels?LabelType=UNIQUE&PackageLabelsToPrint=FBA12A3B4CDEFG5H1,FBA12A3B4CDEFG5H2,FBA12A3B4CDEFG5H3,FBA12A3B4CDEFG5H4&PageType=PackageLabel_Plain_Paper&shipmentID=FBA1232453KJ")
        .to_return(status: 200, body: File.read("./spec/support/get_labels_v0.json"), headers: {})
    end

    def stub_get_shipment_items_by_shipment_id
      stub_request(:get, "https://#{hostname}/fba/inbound/v0/shipments/#{shipment_id}/items?MarketplaceId=#{marketplace_id}")
        .to_return(status: 200, body: File.read("./spec/support/get_shipment_items_by_shipment_id_v0.json"), headers: {})
    end

    def stub_get_item_eligibility_preview
      stub_request(:get, "https://#{hostname}/fba/inbound/v1/eligibility/itemPreview?asin=#{asin}&program=#{program}")
        .to_return(status: 200, body: {"payload"=>{"asin"=>asin, "program"=>program, "isEligibleForProgram"=>true}}.to_json, headers: {})
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
