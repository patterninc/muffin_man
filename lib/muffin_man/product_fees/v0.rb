module MuffinMan
  module ProductFees
    class V0 < SpApiClient

      # Returns the estimated fees for the item indicated by the specified ASIN in the marketplace specified in the request body.  You can call `getMyFeesEstimateForASIN` for an item on behalf of a selling partner before the selling partner sets the item's price. The selling partner can then take estimated fees into account. Each fees request must include an original identifier. This identifier is included in the fees estimate so you can correlate a fees estimate with the original request.  **Note:** This identifier value is only an estimate, actual costs may vary. Search \"fees\" in [Seller Central](https://sellercentral.amazon.com/) and consult the store-specific fee schedule for the most up-to-date information.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 1 | 2 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, see [Usage Plans and Rate Limits in the Selling Partner API](doc:usage-plans-and-rate-limits-in-the-sp-api).
      # @param id_value asin The Amazon Standard Identification Number (ASIN) of the item.
      # @param fees_estimate_request is object of MuffinMan::Helpers::Fees::FeesEstimateRequest
      # @return [GetMyFeesEstimateResponse] 
      def get_my_fees_estimate_for_sku(id_value, fees_estimate_request)
        @local_var_path = "/products/fees/v0/listings/#{id_value}/feesEstimate"
        @request_type = "POST"
        @request_body = build_request_body_for_estimate (fees_estimate_request)

        call_api
      end

      # Returns the estimated fees for the item indicated by the specified ASIN in the marketplace specified in the request body.  You can call `getMyFeesEstimateForASIN` for an item on behalf of a selling partner before the selling partner sets the item's price. The selling partner can then take estimated fees into account. Each fees request must include an original identifier. This identifier is included in the fees estimate so you can correlate a fees estimate with the original request.  **Note:** This identifier value is only an estimate, actual costs may vary. Search \"fees\" in [Seller Central](https://sellercentral.amazon.com/) and consult the store-specific fee schedule for the most up-to-date information.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 1 | 2 |  The `x-amzn-RateLimit-Limit` response header returns the usage plan rate limits that were applied to the requested operation, when available. The table above indicates the default rate and burst values for this operation. Selling partners whose business demands require higher throughput may see higher rate and burst values than those shown here. For more information, see [Usage Plans and Rate Limits in the Selling Partner API](doc:usage-plans-and-rate-limits-in-the-sp-api).
      # @param id_value asin The Amazon Standard Identification Number (ASIN) of the item.
      # @param fees_estimate_request is object of MuffinMan::Helpers::Fees::FeesEstimateRequest
      # @return [GetMyFeesEstimateResponse] 
      def get_my_fees_estimate_for_asin(id_value, fees_estimate_request)
        @local_var_path = "/products/fees/v0/items/#{id_value}/feesEstimate"
        @request_type = "POST"
        @request_body = build_request_body_for_estimate (fees_estimate_request)

        call_api
      end

      def get_my_fees_estimates(fees_estimate_by_id_requests)
        @local_var_path = "/products/fees/v0/feesEstimate"
        @request_type = "POST"
        @request_body = build_request_body_for_estimate_by_ids fees_estimate_by_id_requests

        call_api
      end

      private 

      def build_request_body_for_estimate fees_estimate_request
        return nil if fees_estimate_request == nil
        
        fees_estimate_request.to_camelize
      end

      def build_request_body_for_estimate_by_ids fees_estimate_by_id_requests
        return nil if fees_estimate_by_id_requests == nil

        objects = if fees_estimate_by_id_requests.is_a? Array
          fees_estimate_by_id_requests
        else
          [fees_estimate_by_id_requests]
        end

        request_object = []
        objects.each do |fees_estimate_id_object|
          request_object << fees_estimate_id_object.to_camelize
        end

        return request_object
      end
    end
  end
end
