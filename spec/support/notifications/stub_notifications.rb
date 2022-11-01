# frozen_string_literal: true

def stub_create_destination
  stub_request(:post, "https://#{hostname}/notifications/v1/destinations")
    .with(body: { resourceSpecification: { sqs: { arn: arn } }, name: "Feed process finish notification" })
    .to_return(status: 200, body: File.read("./spec/support/notifications/create_destinations.json"), headers: {})
end

def stub_get_destinations
  stub_request(:get, "https://#{hostname}/notifications/v1/destinations")
    .to_return(status: 200, body: File.read("./spec/support/notifications/get_destinations.json"), headers: {})
end

def stub_get_destination
  stub_request(:get, "https://#{hostname}/notifications/v1/destinations/#{destination_id}")
    .to_return(
      status: 200,
      body: {
        payload: JSON.parse(File.read("./spec/support/notifications/get_destinations.json"))["payload"].first
      }.to_json,
      headers: {}
    )
end

def stub_create_subscription
  stub_request(:post, "https://#{hostname}/notifications/v1/subscriptions/#{notification_type}")
    .with(body: { payloadVersion: "1.0", destinationId: destination_id,
                  processingDirective: {
                    eventFilter: {
                      eventFilterType: notification_type,
                      marketplaceIds: "ASWDDXDER323",
                      aggregationSettings: { aggregationTimePeriod: "FiveMinutes" }
                    }
                  } })
    .to_return(status: 200, body: File.read("./spec/support/notifications/create_subscriptions.json"), headers: {})
end

def stub_get_subscription
  stub_request(:get, "https://#{hostname}/notifications/v1/subscriptions/#{notification_type}")
    .to_return(status: 200, body: File.read("./spec/support/notifications/get_subscriptions.json"), headers: {})
end

def stub_get_subscription_by_id
  stub_request(:get, "https://#{hostname}/notifications/v1/subscriptions/#{notification_type}/#{subscription_id}")
    .to_return(status: 200, body: File.read("./spec/support/notifications/get_subscriptions.json"), headers: {})
end

def stub_delete_subscription_by_id
  stub_request(:delete, "https://#{hostname}/notifications/v1/subscriptions/#{notification_type}/#{subscription_id}")
    .to_return(
      status: 200,
      body: {
        errors: JSON.parse(File.read("./spec/support/notifications/get_destinations.json"))["errors"]
      }.to_json,
      headers: {}
    )
end
