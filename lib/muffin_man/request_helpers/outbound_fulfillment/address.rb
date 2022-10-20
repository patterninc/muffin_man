module MuffinMan
  module RequestHelpers
    module OutboundFulfillment
      class Address
        attr_accessor :name, :address_line1, :address_line2, :address_line3, :city,
                  :district_or_country, :state_or_region, :country_code, :postal_code, :phone

        # Initializes the object
        # @param [Hash] attributes Model attributes in the form of hash
        def initialize(attributes = {})
          return unless attributes.is_a?(Hash)

          if attributes.has_key?('name')
            self.name = attributes['name']
          end

          if attributes.has_key?('address_line1') || attributes.has_key?('line1')
            self.address_line1 = attributes['address_line1'] || attributes['line1']
          end

          if attributes.has_key?('address_line2') || attributes.has_key?('line2')
            self.address_line2 = attributes['address_line2'] || attributes['line2']
          end

          if attributes.has_key?('address_line3') || attributes.has_key?('line3')
            self.address_line3 = attributes['address_line3'] || attributes('line3')
          end

          if attributes.has_key?('city')
            self.city = attributes['city']
          end

          if attributes.has_key?('district_or_country')
            self.district_or_country = attributes['district_or_country']
          end

          if attributes.has_key?('state_or_region') || attributes.has_key?('state_or_province_code')
            self.state_or_region = attributes['state_or_region'] || attributes['state_or_province_code']
          end

          if attributes.has_key?('postal_code')
            self.postal_code = attributes['postal_code']
          end

          if attributes.has_key?('country_code')
            self.country_code = attributes['country_code']
          end

          if attributes.has_key?('phone')
            self.phone = attributes['phone']
          end
        end

        # Formate request object in sp-api request format
        # @return hash for sp-api request format
        def to_camelize
          {
            "name" => name,
            "addressLine1" => address_line1,
            "addressLine2" => address_line2,
            "addressLine3" => address_line3,
            "city" => city,
            "districtOrCounty" => district_or_country,
            "stateOrRegion" => state_or_region,
            "countryCode" => country_code,
            "postalCode" => postal_code,
            "phone" => phone
          }
        end
      end
    end
  end
end
