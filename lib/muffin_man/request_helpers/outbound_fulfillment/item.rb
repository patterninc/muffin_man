module MuffinMan
  module RequestHelpers
    module OutboundFulfillment
      class Item < MuffinMan::RequestHelpers::Base
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
          attributes = attributes.with_indifferent_access

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

        # Check to see if the all the properties in the model are valid
        # @return true if the model is valid
        def valid?
          return false if seller_sku.nil?
          return false if seller_fulfillment_order_item_id.nil?
          return false if quantity.nil?
          true
        end

        # Show invalid properties with the reasons.
        # @return Array for invalid properties with the reasons
        def errors
          errors = Array.new
          if seller_sku.blank?
            errors.push('invalid value for "seller_sku", seller_sku cannot be nil.')
          end

          if seller_fulfillment_order_item_id.blank?
            errors.push('invalid value for "seller_fulfillment_order_item_id", seller_fulfillment_order_item_id cannot be nil.')
          end

          if quantity.blank?
            errors.push('invalid value for "quantity", quantity cannot be nil.')
          end

          errors
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