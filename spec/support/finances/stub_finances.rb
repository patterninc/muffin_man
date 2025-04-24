# frozen_string_literal: true

def stub_list_financial_transactions(posted_after:, posted_before: nil)
  url = "https://#{hostname}/finances/2024-06-19/transactions?postedAfter=#{posted_after}"
  url += "&postedBefore=#{posted_before}" if posted_before
  stub_request(:get, url)
    .to_return(status: 200, body: File.read("./spec/support/finances/list_transactions.json"), headers: {})
end
