# MuffinMan

![Ruby CI](https://github.com/patterninc/muffin_man/actions/workflows/ci.yml/badge.svg)

MuffinMan is a ruby interface to the Amazon Selling Partner API. For more information on registering to use the Selling Partner API, see [Amazon's documentation](https://github.com/amzn/selling-partner-api-docs/blob/main/guides/developer-guide/SellingPartnerApiDeveloperGuide.md)

As of now, this gem only supports the `create_product_review_and_seller_feedback_solicitation` model, likely with more to come.

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
}
client = MuffinMan::Solicitations.new(credentials)
response = client.create_product_review_and_seller_feedback_solicitation(amazon_order_id, marketplace_ids)
JSON.parse(response.body)
```

You can optionally use Amazon's sandbox environment by specifying `client = MuffinMan::Solicitations.new(credentials, sandbox = true)`

You can save and retrieve the LWA refresh token by defining a lambda in your initializers.

For example, if you are using Redis as your cache you could define:

```ruby
@@redis = Redis.new
MuffinMan.configure do |config|
  config.save_access_token = -> (client_id, token) do
    @@redis.set("SP-TOKEN-#{client_id}", token['access_token'], ex: token['expires_in'])
  end

  config.get_access_token = -> (client_id) { @@redis.get("SP-TOKEN-#{client_id}") }
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/patterninc/muffin_man. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/patterninc/muffin_man/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MuffinMan project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/muffin_man/blob/master/CODE_OF_CONDUCT.md).
