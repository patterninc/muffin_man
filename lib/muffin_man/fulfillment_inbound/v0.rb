module MuffinMan
  module FulfillmentInbound
    class V0 < SpApiClient
      def get_prep_instructions(ship_to_country_code, seller_sku_list: [], asin_list: [])
        @local_var_path = "/fba/inbound/v0/prepInstructions"
        @query_params = {
          "ShipToCountryCode" => ship_to_country_code
        }
        @query_params["SellerSKUList"] = seller_sku_list.join(",") if seller_sku_list.any?
        @query_params["ASINList"] = asin_list.join(",") if asin_list.any?
        @request_type = "GET"
        call_api
      end

      def create_inbound_shipment_plan(ship_from_address, label_prep_preference, inbound_shipment_plan_request_items, ship_to_country_code: nil, ship_to_country_subdivision_code: nil)
        @local_var_path = "/fba/inbound/v0/plans"
        @request_body = {
          "ShipFromAddress" => ship_from_address,
          "LabelPrepPreference" => label_prep_preference,
          "InboundShipmentPlanRequestItems" => inbound_shipment_plan_request_items,
        }
        @request_body["ShipToCountryCode"] = ship_to_country_code unless ship_to_country_code.nil?
        @request_body["ShipToCountrySubdivisionCode"] = ship_to_country_subdivision_code unless ship_to_country_subdivision_code.nil?
        @request_type = "POST"
        call_api
      end

      def create_inbound_shipment(shipment_id, marketplace_id, inbound_shipment_header, inbound_shipment_items)
        @local_var_path = "/fba/inbound/v0/shipments/#{shipment_id}"
        @request_body = {
          "MarketplaceId": marketplace_id,
          "InboundShipmentHeader": inbound_shipment_header,
          "InboundShipmentItems": inbound_shipment_items,
        }
        @request_type = "POST"
        call_api
      end

      def get_shipments(query_type, marketplace_id, shipment_status_list: [], shipment_id_list: [], last_updated_after: nil, last_updated_before: nil, next_token: nil)
        @local_var_path = "/fba/inbound/v0/shipments"
        @query_params = {
          "MarketplaceId" => marketplace_id,
          "QueryType" => query_type,
        }
        @query_params["ShipmentStatusList"] = shipment_status_list.join(",") if shipment_status_list.any?
        @query_params["ShipmentIdList"] = shipment_id_list.join(",") if shipment_id_list.any?
        @query_params["LastUpdatedAfter"] = last_updated_after unless last_updated_after.nil?
        @query_params["LastUpdatedBefore"] = last_updated_before unless last_updated_before.nil?
        @query_params["NextToken"] = next_token unless next_token.nil?

        @request_type = "GET"
        call_api
      end

      def update_inbound_shipment(shipment_id, marketplace_id, inbound_shipment_header, inbound_shipment_items)
        @local_var_path = "/fba/inbound/v0/shipments/#{shipment_id}"
        @request_body = {
          "MarketplaceId": marketplace_id,
          "InboundShipmentHeader": inbound_shipment_header,
          "InboundShipmentItems": inbound_shipment_items,
        }
        @request_type = "PUT"
        call_api
      end

      SANDBOX_GET_LABELS_PARAMS = {
        "shipmentId" => "348975493",
        "PageType" => "PackageLabel_Letter_2",
        "LabelType" => "BARCODE_2D"
      }.freeze
      def get_labels(shipment_id, page_type, label_type, number_of_packages: nil, package_labels_to_print: [], number_of_pallets: nil, page_size: nil, page_start_index: nil)
        @query_params = {
          "shipmentID" => shipment_id,
          "PageType" => page_type,
          "LabelType" => label_type
        }
        if sandbox
          shipment_id = SANDBOX_GET_LABELS_PARAMS["shipmentId"]
          @query_params = SANDBOX_GET_LABELS_PARAMS.except("shipmentId")
        else
          @query_params["NumberOfPackages"] = number_of_packages unless number_of_packages.nil?
          @query_params["PackageLabelsToPrint"] = package_labels_to_print.join(",") if package_labels_to_print.any?
          @query_params["NumberOfPallets"] = number_of_pallets unless number_of_pallets.nil?
          @query_params["PageSize"] = page_size unless page_size.nil?
          @query_params["PageStartIndex"] = page_start_index unless page_start_index.nil?
        end
        @local_var_path = "/fba/inbound/v0/shipments/#{shipment_id}/labels"
        @request_type = "GET"
        call_api
      end

      def get_shipment_items_by_shipment_id(shipment_id, marketplace_id)
        @local_var_path = "/fba/inbound/v0/shipments/#{shipment_id}/items"
        @query_params = {
          "MarketplaceId" => marketplace_id,
        }
        @request_type = "GET"
        call_api
      end

      def put_transport_details(shipment_id, is_partnered, shipment_type, transport_details)
        @local_var_path = "/fba/inbound/v0/shipments/#{shipment_id}/transport"
        @request_body = {
          "shipmentId": shipment_id,
          "IsPartnered": is_partnered,
          "ShipmentType": shipment_type,
          "TransportDetails": transport_details,
        }
        @request_type = "PUT"
        call_api
      end

      SANDBOX_SHIPMENT_ID = "shipmentId1".freeze
      def estimate_transport(shipment_id)
        shipment_id = SANDBOX_SHIPMENT_ID if sandbox
        @local_var_path = "/fba/inbound/v0/shipments/#{shipment_id}/transport/estimate"
        @request_type = "POST"
        call_api
      end

      def get_transport_details(shipment_id)
        shipment_id = SANDBOX_SHIPMENT_ID if sandbox
        @local_var_path = "/fba/inbound/v0/shipments/#{shipment_id}/transport"
        @request_type = "GET"
        call_api
      end

      def confirm_transport(shipment_id)
        shipment_id = SANDBOX_SHIPMENT_ID if sandbox
        @local_var_path = "/fba/inbound/v0/shipments/#{shipment_id}/transport/confirm"
        @request_type = "POST"
        call_api
      end

      def void_transport(shipment_id)
        shipment_id = SANDBOX_SHIPMENT_ID if sandbox
        @local_var_path = "/fba/inbound/v0/shipments/#{shipment_id}/transport/void"
        @request_type = "POST"
        call_api
      end
    end
  end
end
