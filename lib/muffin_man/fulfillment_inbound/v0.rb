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
    end
  end
end
