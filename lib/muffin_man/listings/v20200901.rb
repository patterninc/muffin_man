module MuffinMan
  module Listings
    class V20200901 < SpApiClient

      REQUIREMENTS = %w(LISTING LISTING_PRODUCT_ONLY LISTING_OFFER_ONLY).freeze
      REQUIREMENTS_ENFORCED = %w(ENFORCED NOT_ENFORCED).freeze
      LOCALE = %w(DEFAULT ar ar_AE de de_DE en en_AE en_AU en_CA en_GB en_IN en_SG en_US es es_ES es_MX es_US fr 
        fr_CA fr_FR it it_IT ja ja_JP nl nl_NL pl pl_PL pt pt_BR pt_PT sv sv_SE tr tr_TR zh zh_CN zh_TW).freeze

      def search_definitions_product_types(marketplace_ids, keywords = nil)
        @local_var_path = "/definitions/2020-09-01/productTypes"
        @marketplace_ids = marketplace_ids.is_a?(Array) ? marketplace_ids : [marketplace_ids]
        @query_params = { "marketplaceIds" =>  @marketplace_ids.join(",") }
        @query_params["keywords"] = keywords if keywords.present?
        @request_type = "GET"
        call_api
      end

      def get_definitions_product_type(product_type, marketplace_ids, options = {})
        options = options.with_indifferent_access
        @local_var_path = "/definitions/2020-09-01/productTypes/#{product_type}"
        @marketplace_ids = marketplace_ids.is_a?(Array) ? marketplace_ids : [marketplace_ids]
        @query_params = { "marketplaceIds" =>  @marketplace_ids.join(",") }
        @query_params["sellerId"] = options["sellerId"] if options["sellerId"]
        @query_params["productTypeVersion"] = options["productTypeVersion"].upcase if options["productTypeVersion"]
        if REQUIREMENTS.include?(options["requirements"]&.upcase)
          @query_params["requirements"] = options["requirements"].upcase
        end 

        if REQUIREMENTS_ENFORCED.include?(options["requirementsEnforced"]&.upcase)
          @query_params["requirementsEnforced"] = options["requirementsEnforced"].upcase
        end 
        
        if LOCALE.include?(options["locale"])
          @query_params["locale"] = options["locale"]
        end

        @request_type = "GET"
        call_api
      end
    end
  end
end
  