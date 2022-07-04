module MuffinMan
  module MerchantFulfillment
    class V0 < SpApiClient

      def getEligibleShipmentServicesOld(body)
        @request_body = body
        @local_var_path = "/mfn/v0/eligibleServices"
        @request_type = "POST"
        call_api
      end

      def getEligibleShipmentServices(body)
        @request_body = body
        @local_var_path = "/mfn/v0/eligibleShippingServices"
        @request_type = "POST"
        call_api
      end

      def getShipment(shipmentId) 
        @local_var_path = "/mfn/v0/shipments/#{shipmentId}"
        @request_type = "GET"
        call_api
      end

      def cancelShipment(shipmentId) 
        @local_var_path = "/mfn/v0/shipments/#{shipmentId}"
        @request_type = "DELETE"
        call_api
      end

      def cancelShipmentOld(shipmentId) 
        @local_var_path = "/mfn/v0/shipments/#{shipmentId}/cancel"
        @request_type = "PUT"
        call_api
      end

      def createShipment(body)
        @request_body = body
        @local_var_path = "/mfn/v0/shipments"
        @request_type = "POST"
        call_api
      end

      def getAdditionalSellerInputsOld(body)
        @request_body = body
        @local_var_path = "/mfn/v0/sellerInputs"
        @request_type = "POST"
        call_api
      end

      def getAdditionalSellerInputs(body)
        @request_body = body
        @local_var_path = "/mfn/v0/additionalSellerInputs"
        @request_type = "POST"
        call_api
      end


    end
  end
end 