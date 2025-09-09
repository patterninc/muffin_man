# frozen_string_literal: true

module MuffinMan
  module VendorDirectFulfillmentInventory
    class V1 < SpApiClient
      def submit_inventory_update(warehouse_id, selling_party, is_full_update, items)
        @local_var_path = "/vendor/directFulfillment/inventory/v1/warehouses/#{warehouse_id}/items"
        @request_body = {
          "inventory" => {
            "sellingParty" => selling_party,
            "isFullUpdate" => is_full_update,
            "items" => items
          }
        }
        @request_type = "POST"
        call_api
      end
    end
  end
end
