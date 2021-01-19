RSpec.describe MuffinMan::SpApiClient do

  describe 'create_product_review_and_seller_feedback_solicitation' do

    let(:credentials) {
      {
        refresh_token: 'a-refresh-token',
        client_id: 'a-client-id',
        client_secret: 'a-client-secret',
        aws_access_key_id: 'an-aws-access-key-id',
        aws_secret_access_key: 'an-aws-secret-access-key',
        sts_iam_role_arn: 'an-sts-iam-role-arn',
        region: 'us-east-1'
      }
    }
    let(:amazon_order_id) { "123-1234567-1234567" }
    let(:marketplace_ids) { "ATVPDKIKX0DER" }


  end
end
