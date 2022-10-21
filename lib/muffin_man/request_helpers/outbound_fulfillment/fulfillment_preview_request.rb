module MuffinMan
  module RequestHelpers
    module OutboundFulfillment
      class FulfillmentPreviewRequest < MuffinMan::RequestHelpers::Base
        attr_accessor :address, :items, :optional_params

        OPTIONAL_FULFILLMENT_PREVIEW_PARAMS = %w[
          marketplaceId
          shippingSpeedCategories
          includeCODFulfillmentPreview
          includeDeliveryWindows
          featureConstraints
        ].freeze

        # Initializes the object
        # @param [MuffinMan::RequestHelpers::OutboundFulfillment::Address] address in the form of object
        # @param[MuffinMan::RequestHelpers::OutboundFulfillment::Item] items in the form of list of items objects
        # @param [Hash] optional_params optional sp-api attributes in the form of hash
        def initialize(address, items, optional_params={})
          @address = address
          @items = items
          @optional_params = optional_params
        end

        # Check to see if the all the properties in the model are valid
        # @return true if the model is valid
        def valid?
          return false if address.blank? || !address.is_a?(MuffinMan::RequestHelpers::OutboundFulfillment::Address)
          return false if items.blank? || !items.is_a?(Array)

          return false if !address.valid? || items.map(&:valid?).include?(false)

          true
        end

        # Show invalid properties with the reasons.
        # @return Array for invalid properties with the reasons
        def errors
          errors = Array.new

          if address.blank?
            errors.push('invalid value for "address", address cannot be nil.')
          end

          if items.blank?
            errors.push('invalid value for "items", address cannot be nil.')
          end

          if address.present? && !address.valid?
            errors.push('invalid value for "address",' + "#{address.errors}")
          end

          if items.present? && items.map(&:valid?).include?(false)
            errors.push('invalid value for "items", invalid item value.')
          end

          errors
        end

        # Formate request object in sp-api request format
        # @return hash for sp-api request format
        def to_camelize
          {
            "address" => address.to_camelize,
            "items" => items.map(&:to_camelize)
          }.merge!(optional_params.slice(*OPTIONAL_FULFILLMENT_PREVIEW_PARAMS))
        end
      end
    end
  end
end