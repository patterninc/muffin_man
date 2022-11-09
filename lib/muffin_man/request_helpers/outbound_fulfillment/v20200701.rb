# frozen_string_literal: true

module MuffinMan
  module RequestHelpers
    module OutboundFulfillment
      class V20200701
        def self.address_request(name, address_line1, state_or_region, country_code, optional_params = {})
          Address.new({
            "name" => name,
            "address_line1" => address_line1,
            "state_or_region" => state_or_region,
            "country_code" => country_code
          }.merge(optional_params))
        end

        def self.item_request(seller_sku, seller_fulfillment_order_item_id, quantity, optional_params = {})
          Item.new({
            "seller_sku" => seller_sku,
            "seller_fulfillment_order_item_id" => seller_fulfillment_order_item_id,
            "quantity" => quantity
          }.merge(optional_params))
        end

        def self.fulfillment_order_request(seller_fulfillment_order_id, displayable_order_id,
                                           displayable_order_date_time,
                                           displayable_order_comment, shipping_speed_category,
                                           destination_address, items, optional_params = {})
          FulfillmentOrderRequest.new(seller_fulfillment_order_id, displayable_order_id, displayable_order_date_time,
                                      displayable_order_comment, shipping_speed_category, destination_address,
                                      items, optional_params)
        end

        def self.fulfillment_preview_request(address, items, optional_params = {})
          FulfillmentPreviewRequest.new(address, items, optional_params)
        end
      end
    end
  end
end
