module MuffinMan
  module RequestHelpers
    module OutboundFulfillment
      class Address < MuffinMan::RequestHelpers::Base
        attr_accessor :name, :address_line1, :address_line2, :address_line3, :city,
                  :district_or_county, :state_or_region, :country_code, :postal_code, :phone

        # Initializes the object
        # @param [Hash] attributes Model attributes in the form of hash
        def initialize(attributes = {})
          return unless attributes.is_a?(Hash)

          attributes = attributes.with_indifferent_access

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

          if attributes.has_key?('district_or_county')
            self.district_or_county = attributes['district_or_county']
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

        # return true if the model is valid
        def valid?
          return false if name.blank?
          return false if address_line1.blank?
          return false if state_or_region.blank?
          return false if country_code.blank?

          true
        end

        #Show invalid properties with the reasons.
        #return Array for invalid properties with the reasons
        def errors
          errors = Array.new
          if name.blank?
            errors.push('invalid value for "name", name cannot be nil.')
          end

          if address_line1.blank?
            errors.push('invalid value for "address_line1", address_line1 cannot be nil.')
          end

          if state_or_region.blank?
            errors.push('invalid value for "state_or_region", state_or_region cannot be nil.')
          end

          if country_code.blank?
            errors.push('invalid value for "country_code", country_code cannot be nil.')
          end

          errors
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
            "districtOrCounty" => district_or_county,
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
