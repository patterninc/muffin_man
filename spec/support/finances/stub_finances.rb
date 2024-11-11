# frozen_string_literal: true

def stub_list_financial_transactions(posted_after:)
  stub_request(:get, "https://#{hostname}/finances/2024-06-19/transactions?postedAfter=#{posted_after}")
    .to_return(status: 200, body: File.read("./spec/support/finances/list_transactions.json"), headers: {})
end
