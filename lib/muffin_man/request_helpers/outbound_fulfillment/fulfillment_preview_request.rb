module MuffinMan
  module RequestHelpers
    module OutboundFulfillment
      class FulfillmentPreviewRequest
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
