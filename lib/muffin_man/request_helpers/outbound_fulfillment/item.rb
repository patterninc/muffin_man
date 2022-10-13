module MuffinMan
  module RequestHelpers
    module OutboundFulfillment
      class Item
        attr_accessor :seller_sku, :seller_fulfillment_order_item_id, :quantity, :per_unit_declared_value, :optional_params

        OPTIONAL_ITEM_PARAMS = %w[
          perUnitDeclaredValue
          giftMessage
          displayableComment
          fulfillmentNetworkSku
          perUnitDeclaredValue
          perUnitPrice
          perUnitTax
        ].freeze

        # Initializes the object
        # @param [Hash] attributes Model attributes in the form of hash
        def initialize(attributes = {})
          return unless attributes.is_a?(Hash)

          if attributes.has_key?('seller_sku')
            @seller_sku = attributes['seller_sku']
          end

          if attributes.has_key?('seller_fulfillment_order_item_id')
            @seller_fulfillment_order_item_id = attributes['seller_fulfillment_order_item_id']
          end

          if attributes.has_key?('quantity')
            @quantity = attributes['quantity']
          end

          @optional_params = attributes.slice(*OPTIONAL_ITEM_PARAMS)
        end

        def to_camelize
          {
            "sellerSku"=>seller_sku,
            "sellerFulfillmentOrderItemId"=>seller_fulfillment_order_item_id,
            "quantity"=>quantity,
          }.merge!(optional_params.slice(*OPTIONAL_ITEM_PARAMS))
        end
      end
    end
  end
end
