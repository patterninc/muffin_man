module MuffinMan
  module Fees
    class V0 < SpApiClient
      def get_my_fees_estimate_for_sku(id_value, fees_estimate_request)
        @local_var_path = "/products/fees/v0/listings/#{id_value}/feesEstimate"
        @request_type = "POST"
        @request_body = build_request_body_for_estimate (fees_estimate_request)

        call_api
      end

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
