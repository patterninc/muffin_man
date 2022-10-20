module MuffinMan
  module RequestHelpers
    module OutboundFulfillment
      class FulfillmentOrderRequest
        attr_accessor :seller_fulfillment_order_id, :displayable_order_id, :displayable_order_date_time, :displayable_order_comment, :shipping_speed_category, :destination_address, :items, :optional_params

        OPTIONAL_CREATE_FULFILLMENT_ORDER_PARAMS = %w[
          marketplaceId
          deliveryWindow
          fulfillmentAction
          fulfillmentPolicy
          codSettings
          shipFromCountryCode
          notificationEmails
          featureConstraints
        ].freeze


        # Initializes the object
        # @param [String] seller_fulfillment_order_id
        # @param [String] displayable_order_id 
        # @param [String] displayable_order_date_time 
        # @param [String] displayable_order_comment 
        # @param [String] shipping_speed_category
        # @param [MuffinMan::RequestHelpers::OutboundFulfillment::Address] destination_address in form of object
        # @param [MuffinMan::RequestHelpers::OutboundFulfillment::Item] items in the form of list of items objects 
        # @param [Hash] optional_params optional sp-api attributes in the form of hash
        def initialize(seller_fulfillment_order_id, displayable_order_id, displayable_order_date_time, displayable_order_comment, shipping_speed_category, destination_address, items, optional_params = {})
          @seller_fulfillment_order_id = seller_fulfillment_order_id
          @displayable_order_id = displayable_order_id
          @displayable_order_date_time = displayable_order_date_time
          @displayable_order_comment = displayable_order_comment
          @shipping_speed_category = shipping_speed_category
          @destination_address = destination_address
          @items = items
          @optional_params = optional_params
        end

        # Formate request object in sp-api request format
        # @return hash for sp-api request format
        def to_camelize
          {
            "sellerFulfillmentOrderId" => seller_fulfillment_order_id,
            "displayableOrderId" => displayable_order_id,
            "displayableOrderDate" => displayable_order_date_time,
            "displayableOrderComment" => displayable_order_comment,
            "shippingSpeedCategory" => shipping_speed_category,
            "destinationAddress" => destination_address,
            "items" => items.map(&:to_camelize)
          }.merge!(optional_params.slice(*OPTIONAL_CREATE_FULFILLMENT_ORDER_PARAMS))
        end
      end
    end
  end
end
