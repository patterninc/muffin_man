# MuffinMan

[![Ruby CI](https://github.com/patterninc/muffin_man/actions/workflows/ci.yml/badge.svg)](https://github.com/patterninc/muffin_man/actions)

MuffinMan is a ruby interface to the Amazon Selling Partner API. For more information on registering to use the Selling Partner API, see [Amazon's documentation](https://github.com/amzn/selling-partner-api-docs/blob/main/guides/en-US/developer-guide/SellingPartnerApiDeveloperGuide.md)

As of now, this gem only supports portions of the following APIs with more to come:

- `Customer Feedback Insights API v2024-06-01`
- `Amazon Warehousing and Distribution API v2024-05-09`
- `Catalog Items API v2022-04-01`
- `Data Kiosk API v2023-11-15`
- `FBA Inventory API v1`
- `Feeds API v2021-06-30`
- `Finances API v0`
- `Fulfillment Inbound API v2024-03-20`
- `Fulfillment Outbound API v2020-07-01`
- `Listings API v2021-08-01`
- `Listings API v2020-09-01`
- `Listings Restrictions API v2021-08-01`
- `Merchant Fulfillment API v0`
- `Notifications API v1`
- `Orders API v0`
- `Product Fees API v0`
- `Product Pricing API v0`
- `Reports API v2021-06-30`
- `Solicitations API v1`
- `Tokens API v2021-03-01`
- `Vendor Direct Fulfillment Transactions API v1`
- `Vendor Direct Fulfillment Orders API v2021-12-28`
- `Vendor Direct Fulfillment Payments API v1`
- `Vendor Direct Fulfillment Shipping API v2021-12-28`
- `Vendor Direct Fulfillment Transactions API v2021-12-28`
- `Vendor Invoices API v1`
- `Vendor Orders API v1`
- `Vendor Shipments API v1`
- `Vendor Transaction Status API v1`

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'muffin_man'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install muffin_man

## Usage

To make a call to the Amazon Selling Partner API, define your credentials and make a call as shown:

```ruby
require 'muffin_man'
credentials = {
  refresh_token: LWA_REFRESH_TOKEN,
  client_id: CLIENT_ID,
  client_secret: CLIENT_SECRET,
  aws_access_key_id: AWS_ACCESS_KEY_ID,
  aws_secret_access_key: AWS_SECRET_ACCESS_KEY,
  region: REGION, # This can be one of ['na', 'eu', 'fe'] and defaults to 'na'
  sts_iam_role_arn: STS_IAM_ROLE_ARN, # Optional
  access_token_cache_key: SELLING_PARTNER_ID, # Optional if you want access token caching
}
client = MuffinMan::Solicitations::V1.new(credentials)
response = client.create_product_review_and_seller_feedback_solicitation(amazon_order_id, marketplace_ids)
JSON.parse(response.body)
```

You can optionally use Amazon's sandbox environment by specifying `client = MuffinMan::Solicitations.new(credentials, sandbox = true)`

### Set Custom Logger

By default MuffinMan will log to standard out. To customize the logger used:

```ruby
MuffinMan.configure do |config|
  config.logger = Logger.new('log/sp-api.log')
end
```

### Access Token Caching

You can save and retrieve the LWA refresh token by defining a lambda in your initializers.

For example, if you are using Redis as your cache you could define:

```ruby
@@redis = Redis.new
MuffinMan.configure do |config|
  config.save_access_token = -> (access_token_cache_key, token) do
    @@redis.set("SP-TOKEN-#{access_token_cache_key}", token['access_token'], ex: token['expires_in'])
  end

  config.get_access_token = -> (access_token_cache_key) { @@redis.get("SP-TOKEN-#{access_token_cache_key}") }
end
```

### Retrieiving the refresh token

To retrieve the refresh token from an LWA Website authorization workflow, you can use the LWA helper:

```ruby
# Get your auth code first, either through the Website oauth flow or Authorization API
credentials = {
  client_id: CLIENT_ID,
  client_secret: CLIENT_SECRET,
  aws_access_key_id: AWS_ACCESS_KEY_ID,
  aws_secret_access_key: AWS_SECRET_ACCESS_KEY,
  sts_iam_role_arn: STS_IAM_ROLE_ARN, # Optional
  scope: 'sellingpartnerapi::migration' # Grantless scope for MWS migration
}
client = MuffinMan::Authorization::V1.new(credentials)
resp = JSON.parse(client.get_authorization_code(seller_id, developer_id, mws_auth_token).body)
auth_code = resp['payload']['authorizationCode']
# Then query retrieve the refresh token to store
refresh_token = MuffinMan::Lwa::AuthHelper.get_refresh_token(CLIENT_ID, CLIENT_SECRET, auth_code)
```

### Debugging

To use Typheous' verbose mode set env variable `MUFFIN_MAN_DEBUG=true`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/patterninc/muffin_man. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/patterninc/muffin_man/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MuffinMan project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/muffin_man/blob/master/CODE_OF_CONDUCT.md).
