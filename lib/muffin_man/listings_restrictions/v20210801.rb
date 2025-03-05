# frozen_string_literal: true

module MuffinMan
  module ListingsRestrictions
    class V20210801 < SpApiClient
      def get_listings_restrictions(asin, seller_id, marketplace_ids, condition_type = nil, reason_locale = nil)
        # Options for condition_type:
        # new_new
        # new_open_box
        # new_oem
        # refurbished_refurbished
        # used_like_new
        # used_very_good
        # used_good
        # used_acceptable
        # collectible_like_new
        # collectible_very_good
        # collectible_good
        # collectible_acceptable
        # club_club

        @local_var_path = "/listings/2021-08-01/restrictions"
        @marketplace_ids = marketplace_ids.is_a?(Array) ? marketplace_ids : [marketplace_ids]
        @query_params = {
          "marketplaceIds" => @marketplace_ids.join(",")
        }
        @query_params["asin"] = asin if asin
        @query_params["conditionType"] = condition_type if condition_type
        @query_params["sellerId"] = seller_id if seller_id
        @query_params["reason_locale"] = reason_locale if reason_locale
        @request_type = "GET"
        call_api
      end
    end
  end
end
