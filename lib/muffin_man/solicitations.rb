module MuffinMan
  class Solicitations < SpApiClient
    SANDBOX_AMAZON_ORDER_ID = "123-1234567-1234567"
    SANDBOX_MARKETPLACE_IDS = "ATVPDKIKX0DER"
    attr_reader :amazon_order_id, :marketplace_ids, :request_type, :local_var_path, :query_params

    # Sends a solicitation to a buyer asking for seller feedback and a product review for the specified order. Send only one productReviewAndSellerFeedback or free form proactive message per order.  **Usage Plan:**  | Rate (requests per second) | Burst | | ---- | ---- | | 1 | 5 |  For more information, see \"Usage Plans and Rate Limits\" in the Selling Partner API documentation.
    # @param amazon_order_id An Amazon order identifier. This specifies the order for which a solicitation is sent.
    # @param marketplace_ids A marketplace identifier. This specifies the marketplace in which the order was placed. Only one marketplace can be specified.
    def create_product_review_and_seller_feedback_solicitation(amazon_order_id, marketplace_ids, region = 'na')
      @region = region
      @amazon_order_id = sandbox ? SANDBOX_AMAZON_ORDER_ID : amazon_order_id
      @marketplace_ids = sandbox ? SANDBOX_MARKETPLACE_IDS : marketplace_ids
      @local_var_path = '/solicitations/v1/orders/{amazonOrderId}/solicitations/productReviewAndSellerFeedback'.sub('{' + 'amazonOrderId' + '}', @amazon_order_id)
      @query_params = { "marketplaceIds" => @marketplace_ids }
      @request_type = 'POST'
      call_api
    end
  end
end
