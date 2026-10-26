# frozen_string_literal: true

def stub_replenishment_search(path, body, response_file)
  stub_request(:post, "https://#{hostname}/replenishment/2022-11-07/#{path}")
    .with { |request| JSON.parse(request.body) == body }
    .to_return(status: 200, body: File.read("./spec/support/replenishment/#{response_file}"), headers: {})
end
