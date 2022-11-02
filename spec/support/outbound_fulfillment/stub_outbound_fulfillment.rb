# frozen_string_literal: true

def stub_list_all_fulfillment_orders
  stub_request(:get, "https://#{hostname}/fba/outbound/2020-07-01/fulfillmentOrders")
    .to_return(status: 200, body: File.read("./spec/support/outbound_fulfillment/list_all_fulfillment_orders.json"),
               headers: {})
end

def stub_list_fulfillment_orders_with_date_token(start_date, next_token)
  stub_request(:get, "https://#{hostname}/fba/outbound/2020-07-01/fulfillmentOrders?queryStartDate=#{start_date}&nextToken=#{next_token}")
    .to_return(status: 200, body: File.read("./spec/support/outbound_fulfillment/list_all_fulfillment_orders.json"),
               headers: {})
end

def stub_get_fulfillment_order(seller_fulfillment_order_id)
  stub_request(:get, "https://#{hostname}/fba/outbound/2020-07-01/fulfillmentOrders/#{seller_fulfillment_order_id}")
    .to_return(status: 200, body: File.read("./spec/support/outbound_fulfillment/get_fulfillment_order.json"),
               headers: {})
end

def stub_cancel_fulfillment_order(seller_fulfillment_order_id)
  stub_request(:put, "https://#{hostname}/fba/outbound/2020-07-01/fulfillmentOrders/#{seller_fulfillment_order_id}/cancel")
    .to_return(status: 200, headers: {})
end

def stub_get_outbound_fulfillment_preview
  stub_request(:post, "https://#{hostname}/fba/outbound/2020-07-01/fulfillmentOrders/preview")
    .to_return(status: 200,
               body: File.read("./spec/support/outbound_fulfillment/get_outbound_fulfillment_preview.json"),
               headers: {})
end

def stub_create_fulfillment_order
  stub_request(:post, "https://#{hostname}/fba/outbound/2020-07-01/fulfillmentOrders")
    .to_return(status: 200, headers: {})
end
