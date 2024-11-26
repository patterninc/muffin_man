require './spec/support/outbound_fulfillment/stub_outbound_fulfillment'
require './spec/support/feeds/stub_feeds'
require './spec/support/notifications/stub_notifications'
require './spec/support/finances/stub_finances'
require './spec/support/uploads/stub_uploads'
require './spec/support/aplus_content/stub_aplus_content_apis'

module Support
  module SpApiHelpers
    def stub_request_access_token
      stub_request(:post, "https://api.amazon.com/auth/o2/token")
        .with(body: "grant_type=refresh_token&refresh_token=a-refresh-token&client_id=a-client-id&client_secret=a-client-secret",
              headers: { "Content-Type" => "application/x-www-form-urlencoded;charset=UTF-8", "Expect" => "",
                         "User-Agent" => "" })
        .to_return(status: 200, body: '{ "access_token": "this_will_get_you_into_drury_lane", "expires_in": 3600 }', headers: {})
    end

    def stub_request_access_token_failed
      stub_request(:post, "https://api.amazon.com/auth/o2/token")
        .with(body: "grant_type=refresh_token&refresh_token=a-refresh-token&client_id=a-client-id&client_secret=a-client-secret",
              headers: { "Content-Type" => "application/x-www-form-urlencoded;charset=UTF-8", "Expect" => "",
                         "User-Agent" => "" })
        .to_return(status: 400,
                   headers: {},
                   body: {
                     "error_description" => "The request has an invalid grant parameter : refresh_token. User may have revoked or didn't grant the permission.",
                     "error" => "invalid_grant"
                   }.to_json)
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

    def stub_search_catalog_items_by_identifier_v20220401
      stub_request(:get, "https://#{hostname}/catalog/2022-04-01/items?identifiers=#{asins}&identifiersType=ASIN&marketplaceIds=#{amazon_marketplace_id}")
        .to_return(status: 200, body: File.read("./spec/support/search_catalog_items_by_identifier_v20220401.json"), headers: {})
    end

    def stub_get_item_review_topics_v20220601
      stub_request(:get, "https://#{hostname}/customerFeedback/2024-06-01/items/#{asin}/reviews/topics?marketplaceId=#{marketplace_id}&sortBy=#{sort_type}")
        .to_return(status: 200, body: File.read("./spec/support/get_item_review_topics.json"), headers: {})
    end

    def stub_get_queries
      stub_request(:get, "https://#{hostname}/dataKiosk/2023-11-15/queries")
        .to_return(status: 200, body: File.read("./spec/support/get_queries.json"), headers: {})
    end

    def stub_create_query
      stub_request(:post, "https://#{hostname}/dataKiosk/2023-11-15/queries")
        .to_return(status: 202, body: { queryId: query_id }.to_json, headers: {})
    end

    def stub_get_query
      stub_request(:get, "https://#{hostname}/dataKiosk/2023-11-15/queries/#{query_id}")
        .to_return(status: 200, body: File.read("./spec/support/get_query.json"), headers: {})
    end

    def stub_cancel_query
      stub_request(:delete, "https://#{hostname}/dataKiosk/2023-11-15/queries/#{query_id}")
        .to_return(status: 204, headers: {})
    end

    def stub_get_document
      stub_request(:get, "https://#{hostname}/dataKiosk/2023-11-15/documents/#{document_id}")
        .to_return(status: 200, body: { documentId: document_id, documentUrl: "https://d34o8swod1owfl.cloudfront.net/QUERY_DATA_OUTPUT_DOC.txt" }.to_json, headers: {})
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

    def stub_get_order
      stub_request(:get, "https://#{hostname}/orders/v0/orders/#{order_id}")
        .to_return(status: 200, body: File.read("./spec/support/get_order.json"), headers: {})
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

    def stub_get_competitive_pricing_batch
      stub_request(:get, "https://#{hostname}/products/pricing/v0/competitivePrice?Asins=#{asins.join("%2C")}&ItemType=#{item_type}&MarketplaceId=#{amazon_marketplace_id}")
        .to_return(status: 200, body: File.read("./spec/support/get_competitive_pricing_batch.json"), headers: {})
    end

    def stub_get_listings_item
      stub_request(:get, "https://#{hostname}/listings/2021-08-01/items/#{seller_id}/#{sku}?marketplaceIds=#{amazon_marketplace_id}")
        .to_return(status: 200, body: File.read("./spec/support/get_listings_item.json"), headers: {})
    end

    def stub_put_listings_item
      stub_request(:put, "https://#{hostname}/listings/2021-08-01/items/#{seller_id}/#{sku}?marketplaceIds=#{amazon_marketplace_id}")
        .to_return(status: 200, body: File.read("./spec/support/put_listings_item.json"), headers: {})
    end

    def stub_delete_listings_item
      stub_request(:delete, "https://#{hostname}/listings/2021-08-01/items/#{seller_id}/#{sku}?marketplaceIds=#{amazon_marketplace_id}&issueLocale=#{issue_locale}")
        .to_return(status: 200, body: File.read("./spec/support/delete_listings_item.json"), headers: {})
    end

    def stub_delete_listings_item_nonexistent_sku
      stub_request(:delete, "https://#{hostname}/listings/2021-08-01/items/#{seller_id}/#{nonexistent_sku}?marketplaceIds=#{amazon_marketplace_id}&issueLocale=#{issue_locale}")
        .to_return(status: 404, body: "", headers: {})
    end

    def stub_patch_listings_item
      stub_request(:patch, "https://#{hostname}/listings/2021-08-01/items/#{seller_id}/#{sku}?marketplaceIds=#{amazon_marketplace_id}")
        .to_return(status: 200, body: File.read("./spec/support/patch_listings_item.json"), headers: {})
    end

    def stub_get_listings_restricted
      stub_request(:get, "https://#{hostname}/listings/2021-08-01/restrictions?asin=#{asin}&conditionType=#{condition_type}&marketplaceIds=#{amazon_marketplace_id}&sellerId=#{seller_id}")
        .to_return(status: 200, body: File.read("./spec/support/get_listings_restrictions_restricted.json"), headers: {})
    end

    def stub_get_listings_unrestricted
      stub_request(:get, "https://#{hostname}/listings/2021-08-01/restrictions?asin=#{asin}&conditionType=#{condition_type}&marketplaceIds=#{amazon_marketplace_id}&sellerId=#{seller_id}")
        .to_return(status: 200, body: File.read("./spec/support/get_listings_restrictions_unrestricted.json"), headers: {})
    end

    def stub_search_definitions_product_types
      stub_request(:get, "https://#{hostname}/definitions/2020-09-01/productTypes?keywords=#{keyword}&marketplaceIds=#{amazon_marketplace_id}")
        .to_return(status: 200, body: File.read("./spec/support/search_definitions_product_types.json"), headers: {})
    end

    def stub_get_definitions_product_type
      stub_request(:get,
                   "https://#{hostname}/definitions/2020-09-01/productTypes/#{product_type}?locale=en_US&marketplaceIds=#{amazon_marketplace_id}&requirementsEnforced=ENFORCED")
        .to_return(status: 200, body: File.read("./spec/support/get_definitions_product_type.json"), headers: {})
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
         with(:body => "{\"IsPartnered\":true,\"ShipmentType\":\"LPL\",\"TransportDetails\":[{\"PartneredSmallParcelData\":[],\"NonPartneredSmallParcelData\":[],\"PartneredLtlData\":[],\"NonPartneredLtlData\":[]}]}").
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

    def stub_get_inventory_summaries_v1
      stub_request(:get, "https://#{hostname}/fba/inventory/v1/summaries?granularityType=#{granularity_type}&granularityId=#{granularity_id}&marketplaceIds=#{marketplace_ids}")
        .to_return(status: 200, body: File.read("./spec/support/get_inventory_summaries_v1.json"), headers: {})
    end

    def stub_estimate_transport
      stub_request(:post, "https://#{hostname}/fba/inbound/v0/shipments/#{shipment_id}/transport/estimate")
        .to_return(status: 200, body: File.read("./spec/support/estimate_transport.json"), headers: {})
    end

    def stub_get_transport_details
      stub_request(:get, "https://#{hostname}/fba/inbound/v0/shipments/#{shipment_id}/transport")
        .to_return(status: 200, body: File.read("./spec/support/get_transport_details.json"), headers: {})
    end

    def stub_confirm_transport
      stub_request(:post, "https://#{hostname}/fba/inbound/v0/shipments/#{shipment_id}/transport/confirm")
        .to_return(status: 200, body: File.read("./spec/support/confirm_transport.json"), headers: {})
    end

    def stub_void_transport
      stub_request(:post, "https://#{hostname}/fba/inbound/v0/shipments/#{shipment_id}/transport/void")
        .to_return(status: 200, body: File.read("./spec/support/void_transport.json"), headers: {})
    end

    def stub_get_eligible_shipment_services
      stub_request(:post, "https://#{hostname}/mfn/v0/eligibleShippingServices")
        .to_return(status: 200, body: File.read("./spec/support/merchant_fulfillment/get_eligible_shipment_services_v0.json"), headers: {})
    end

    def stub_get_shipment
      stub_request(:get, "https://#{hostname}/mfn/v0/shipments/#{shipment_id}")
        .to_return(status: 200, body: File.read("./spec/support/merchant_fulfillment/get_shipment_v0.json"), headers: {})
    end

    def stub_cancel_shipment
      stub_request(:delete, "https://#{hostname}/mfn/v0/shipments/#{shipment_id}")
        .to_return(status: 200, body: File.read("./spec/support/merchant_fulfillment/get_shipment_v0.json"), headers: {})
    end

    def stub_create_shipment
      stub_request(:post, "https://#{hostname}/mfn/v0/shipments")
        .to_return(status: 200, body: File.read("./spec/support/merchant_fulfillment/get_shipment_v0.json"), headers: {})
    end

    def stub_get_additional_seller_inputs
      stub_request(:post, "https://#{hostname}/mfn/v0/additionalSellerInputs")
        .to_return(status: 200, body: File.read("./spec/support/merchant_fulfillment/get_additional_seller_inputs_v0.json"), headers: {})
    end

    def stub_vendor_direct_fulfillment_inventory_v1_submit_inventory_update
      stub_request(:post, "https://#{hostname}/vendor/directFulfillment/inventory/v1/warehouses/#{warehouse_id}/items")
        .to_return(status: 202, body: { transactionId: transaction_id }.to_json, headers: {})
    end

    def stub_vendor_direct_fulfillment_orders_v20211228_get_orders
      stub_request(:get, "https://#{hostname}/vendor/directFulfillment/orders/2021-12-28/purchaseOrders")
        .with(query: { createdAfter: created_after, createdBefore: created_before, limit: params["limit"], sortOrder: params["sortOrder"], includeDetails: params["includeDetails"] })
        .to_return(status: 200, body: File.read("./spec/support/vendor_direct_fulfillment_orders/v20211228_get_orders.json"), headers: {})
    end

    def stub_vendor_direct_fulfillment_orders_v20211228_get_order
      stub_request(:get, "https://#{hostname}/vendor/directFulfillment/orders/2021-12-28/purchaseOrders/#{purchase_order_number}")
        .to_return(status: 200, body: File.read("./spec/support/vendor_direct_fulfillment_orders/v20211228_get_order.json"), headers: {})
    end

    def stub_vendor_direct_fulfillment_orders_v20211228_submit_acknowledgement
      stub_request(:post, "https://#{hostname}/vendor/directFulfillment/orders/2021-12-28/acknowledgements")
        .to_return(status: 202, body: { transactionId: transaction_id }.to_json, headers: {})
    end

    def stub_vendor_direct_fulfillment_payments_v1_submit_invoice
      stub_request(:post, "https://#{hostname}/vendor/directFulfillment/payments/v1/invoices")
        .to_return(status: 202, body: { transactionId: transaction_id }.to_json, headers: {})
    end

    def stub_vendor_direct_fulfillment_shipping_v20211228_get_shipping_labels
      stub_request(:get, "https://#{hostname}/vendor/directFulfillment/shipping/2021-12-28/shippingLabels")
        .with(query: { createdAfter: created_after, createdBefore: created_before, limit: params["limit"], sortOrder: params["sortOrder"] })
        .to_return(status: 200, body: File.read("./spec/support/vendor_direct_fulfillment_shipping/v20211228_get_shipping_labels.json"), headers: {})
    end

    def stub_vendor_direct_fulfillment_shipping_v20211228_submit_shipping_label_request
      stub_request(:post, "https://#{hostname}/vendor/directFulfillment/shipping/2021-12-28/shippingLabels")
        .to_return(status: 202, body: { transactionId: transaction_id }.to_json, headers: {})
    end

    def stub_vendor_direct_fulfillment_shipping_v20211228_get_shipping_label
      stub_request(:get, "https://#{hostname}/vendor/directFulfillment/shipping/2021-12-28/shippingLabels/#{purchase_order_number}")
        .to_return(status: 200, body: File.read("./spec/support/vendor_direct_fulfillment_shipping/v20211228_get_shipping_label.json"), headers: {})
    end

    def stub_vendor_direct_fulfillment_shipping_v20211228_create_shipping_labels
      stub_request(:post, "https://#{hostname}/vendor/directFulfillment/shipping/2021-12-28/shippingLabels/#{purchase_order_number}")
        .to_return(status: 200, body: File.read("./spec/support/vendor_direct_fulfillment_shipping/v20211228_create_shipping_labels.json"), headers: {})
    end

    def stub_vendor_direct_fulfillment_shipping_v20211228_submit_shipment_confirmations
      stub_request(:post, "https://#{hostname}/vendor/directFulfillment/shipping/2021-12-28/shipmentConfirmations")
        .to_return(status: 202, body: { transactionId: transaction_id }.to_json, headers: {})
    end

    def stub_vendor_direct_fulfillment_shipping_v20211228_submit_shipment_status_updates
      stub_request(:post, "https://#{hostname}/vendor/directFulfillment/shipping/2021-12-28/shipmentStatusUpdates")
        .to_return(status: 202, body: { transactionId: transaction_id }.to_json, headers: {})
    end

    def stub_vendor_direct_fulfillment_shipping_v20211228_get_customer_invoices
      stub_request(:get, "https://#{hostname}/vendor/directFulfillment/shipping/2021-12-28/customerInvoices")
        .with(query: { createdAfter: created_after, createdBefore: created_before, limit: params["limit"], sortOrder: params["sortOrder"] })
        .to_return(status: 200, body: File.read("./spec/support/vendor_direct_fulfillment_shipping/v20211228_get_customer_invoices.json"), headers: {})
    end

    def stub_vendor_direct_fulfillment_shipping_v20211228_get_customer_invoice
      stub_request(:get, "https://#{hostname}/vendor/directFulfillment/shipping/2021-12-28/customerInvoices/#{purchase_order_number}")
        .to_return(status: 200, body: { purchaseOrderNumber: purchase_order_number, content: "base 64 encoded string" }.to_json, headers: {})
    end

    def stub_vendor_direct_fulfillment_shipping_v20211228_get_packing_slips
      stub_request(:get, "https://#{hostname}/vendor/directFulfillment/shipping/2021-12-28/packingSlips")
        .with(query: { createdAfter: created_after, createdBefore: created_before, limit: params["limit"], sortOrder: params["sortOrder"] })
        .to_return(status: 200, body: File.read("./spec/support/vendor_direct_fulfillment_shipping/v20211228_get_packing_slips.json"), headers: {})
    end

    def stub_vendor_direct_fulfillment_shipping_v20211228_get_packing_slip
      stub_request(:get, "https://#{hostname}/vendor/directFulfillment/shipping/2021-12-28/packingSlips/#{purchase_order_number}")
        .to_return(status: 200, body: { purchaseOrderNumber: purchase_order_number, content: "base 64 encoded string", contentType: "application/pdf" }.to_json, headers: {})
    end

    def stub_vendor_direct_fulfillment_transactions_v20211228_get_transaction_status
      stub_request(:get, "https://#{hostname}/vendor/directFulfillment/transactions/2021-12-28/transactions/#{transaction_id}")
        .to_return(status: 200, body: File.read("./spec/support/vendor_direct_fulfillment_transactions/v20211228_get_transaction_status.json"), headers: {})
    end

    def stub_vendor_invoices_v1_submit_invoices
      stub_request(:post, "https://#{hostname}/vendor/payments/v1/invoices")
        .to_return(status: 202, body: { payload: payload }.to_json, headers: {})
    end

    def stub_vendor_orders_v1_get_purchase_orders
      stub_request(:get, "https://#{hostname}/vendor/orders/v1/purchaseOrders")
        .with(query: { limit: params["limit"], createdAfter: params["createdAfter"], createdBefore: params["createdBefore"], sortOrder: params["sortOrder"], includeDetails: params["includeDetails"] })
        .to_return(status: 200, body: File.read("./spec/support/vendor_orders/v1_get_purchase_orders.json"), headers: {})
    end

    def stub_vendor_orders_v1_get_purchase_order
      stub_request(:get, "https://#{hostname}/vendor/orders/v1/purchaseOrders/#{purchase_order_number}")
        .to_return(status: 200, body: File.read("./spec/support/vendor_orders/v1_get_purchase_order.json"), headers: {})
    end

    def stub_vendor_orders_v1_submit_acknowledgement
      stub_request(:post, "https://#{hostname}/vendor/orders/v1/acknowledgements")
        .to_return(status: 202, body: { payload: payload }.to_json, headers: {})
    end

    def stub_vendor_orders_v1_get_purchase_orders_status
      stub_request(:get, "https://#{hostname}/vendor/orders/v1/purchaseOrdersStatus")
        .with(query: { limit: params["limit"], createdAfter: params["createdAfter"], createdBefore: params["createdBefore"] })
        .to_return(status: 200, body: File.read("./spec/support/vendor_orders/v1_get_purchase_orders_status.json"), headers: {})
    end

    def stub_vendor_shipments_v1_submit_shipment_confirmations
      stub_request(:post, "https://#{hostname}/vendor/shipping/v1/shipmentConfirmations")
        .to_return(status: 202, body: { payload: payload }.to_json, headers: {})
    end

    def stub_vendor_shipments_v1_get_shipment_details
      stub_request(:get, "https://#{hostname}/vendor/shipping/v1/shipments")
        .with(query: { vendorShipmentIdentifier: params["vendorShipmentIdentifier"] })
        .to_return(status: 200, body: File.read("./spec/support/vendor_shipments/v1_get_shipment_details.json"), headers: {})
    end

    def stub_vendor_shipments_v1_submit_shipments
      stub_request(:post, "https://#{hostname}/vendor/shipping/v1/shipments")
        .to_return(status: 202, body: { payload: payload }.to_json, headers: {})
    end

    def stub_vendor_transaction_status_v1_get_transaction
      stub_request(:get, "https://#{hostname}/vendor/transactions/v1/transactions/#{transaction_id}")
        .to_return(status: 200, body: File.read("./spec/support/vendor_transaction_status/v1_get_transaction.json"), headers: {})
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
