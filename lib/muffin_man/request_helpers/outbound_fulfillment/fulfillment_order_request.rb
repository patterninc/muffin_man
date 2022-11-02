# frozen_string_literal: true

module MuffinMan
  module RequestHelpers
    module OutboundFulfillment
      class FulfillmentOrderRequest < MuffinMan::RequestHelpers::Base
        attr_accessor :seller_fulfillment_order_id, :displayable_order_id, :displayable_order_date_time,
                      :displayable_order_comment, :shipping_speed_category, :destination_address, :items,
                      :optional_params

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
        # rubocop:disable Metrics/ParameterLists
        def initialize(seller_fulfillment_order_id, displayable_order_id, displayable_order_date_time,
                       displayable_order_comment, shipping_speed_category, destination_address, items,
                       optional_params = {})
          super
          @seller_fulfillment_order_id = seller_fulfillment_order_id
          @displayable_order_id = displayable_order_id
          @displayable_order_date_time = displayable_order_date_time
          @displayable_order_comment = displayable_order_comment
          @shipping_speed_category = shipping_speed_category
          @destination_address = destination_address
          @items = items
          @optional_params = optional_params
        end
        # rubocop:enable Metrics/ParameterLists

        # Check to see if the all the properties in the model are valid
        # @return true if the model is valid
        # rubocop:disable Metrics/CyclomaticComplexity
        # rubocop:disable Metrics/PerceivedComplexity
        def valid?
          return false if seller_fulfillment_order_id.blank?
          return false if displayable_order_id.blank?
          return false if displayable_order_date_time.blank?
          return false if displayable_order_comment.blank?
          return false if shipping_speed_category.blank?
          return false if destination_address.blank?
          return false if items.blank?
          return false if destination_address.present? && !destination_address.valid?
          return false if items.present? && items.map(&:valid?).include?(false)

          true
        end

        # Show invalid properties with the reasons.
        # @return Array for invalid properties with the
        def errors
          errors = []
          errors.push('"seller_fulfillment_order_id" cannot be nil.') if seller_fulfillment_order_id.blank?
          errors.push('"displayable_order_id" cannot be nil.') if displayable_order_id.blank?
          errors.push('"displayable_order_date_time" cannot be nil.') if displayable_order_date_time.blank?
          errors.push('"displayable_order_comment" cannot be nil.') if displayable_order_comment.blank?
          errors.push('"shipping_speed_category" cannot be nil.') if shipping_speed_category.blank?
          errors.push('"destination_address" cannot be nil.') if destination_address.blank?
          errors.push('"items" cannot be nil.') if items.blank?

          if !destination_address.nil? && !destination_address.valid?
            errors.push("invalid value for \"destination_address\", #{destination_address.errors}")
          end

          errors.push('invalid value for "items"') if !items.nil? && items.map(&:valid?).include?(false)

          errors
        end
        # rubocop:enable Metrics/CyclomaticComplexity
        # rubocop:enable Metrics/PerceivedComplexity

        # Format request object in sp-api request format
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
