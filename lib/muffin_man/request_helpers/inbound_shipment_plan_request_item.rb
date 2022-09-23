module MuffinMan
  module RequestHelpers
    class InboundShipmentPlanRequestItem < Base
      attr_reader :seller_sku, :asin, :condition, :quantity, :quantity_in_case, :prep_details_list

      def initialize(seller_sku, asin, condition, quantity, quantity_in_case: nil, prep_details_list: [])
        @seller_sku = seller_sku
        @asin = asin
        @quantity = quantity
        @condition = condition
        @quantity_in_case = quantity_in_case
        @prep_details_list = prep_details_list
      end

      def json_body
        {
          "SellerSKU": seller_sku,
          "ASIN": asin,
          "Condition": condition,
          "Quantity": quantity,
          "QuantityInCase": quantity_in_case,
          "PrepDetailsList": prep_details_list
        }
      end
    end
  end
end
