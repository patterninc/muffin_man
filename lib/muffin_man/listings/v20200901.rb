# frozen_string_literal: true

module MuffinMan
  module Listings
    class V20200901 < SpApiClient
      REQUIREMENTS = %w[LISTING LISTING_PRODUCT_ONLY LISTING_OFFER_ONLY].freeze
      REQUIREMENTS_ENFORCED = %w[ENFORCED NOT_ENFORCED].freeze
      LOCALE = %w[DEFAULT ar ar_AE de de_DE en en_AE en_AU en_CA en_GB en_IN en_SG en_US es es_ES es_MX es_US fr
                  fr_CA fr_FR it it_IT ja ja_JP nl nl_NL pl pl_PL pt pt_BR pt_PT sv sv_SE tr tr_TR zh zh_CN zh_TW]
               .freeze
      PRODUCT_TYPES_PATH = "/definitions/2020-09-01/productTypes"

      def search_definitions_product_types(marketplace_ids, keywords = nil)
        @local_var_path = PRODUCT_TYPES_PATH
        @marketplace_ids = marketplace_ids.is_a?(Array) ? marketplace_ids : [marketplace_ids]
        @query_params = { "marketplaceIds" => @marketplace_ids.join(",") }
        @query_params["keywords"] = keywords if keywords.present?
        @request_type = "GET"
        call_api
      end

      # rubocop:disable Metrics/CyclomaticComplexity
      # rubocop:disable Metrics/PerceivedComplexity
      def get_definitions_product_type(product_type, marketplace_ids, options = {})
        options = options.with_indifferent_access
        @local_var_path = "#{PRODUCT_TYPES_PATH}/#{product_type}"
        @marketplace_ids = marketplace_ids.is_a?(Array) ? marketplace_ids : [marketplace_ids]
        @query_params = { "marketplaceIds" => @marketplace_ids.join(",") }
        @query_params["sellerId"] = options["sellerId"] if options["sellerId"]
        @query_params["productTypeVersion"] = options["productTypeVersion"].upcase if options["productTypeVersion"]
        if REQUIREMENTS.include?(options["requirements"]&.upcase)
          @query_params["requirements"] = options["requirements"].upcase
        end

        if REQUIREMENTS_ENFORCED.include?(options["requirementsEnforced"]&.upcase)
          @query_params["requirementsEnforced"] = options["requirementsEnforced"].upcase
        end

        @query_params["locale"] = options["locale"] if LOCALE.include?(options["locale"])

        @request_type = "GET"
        call_api
      end
      # rubocop:enable Metrics/CyclomaticComplexity
      # rubocop:enable Metrics/PerceivedComplexity
    end
  end
end
