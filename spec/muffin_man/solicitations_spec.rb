RSpec.describe MuffinMan::Solicitations do
  before do
    stub_request_access_token
    stub_solicitations
  end
  let(:credentials) {
    {
      refresh_token: 'a-refresh-token',
      client_id: 'a-client-id',
      client_secret: 'a-client-secret',
      aws_access_key_id: 'an-aws-access-key-id',
      aws_secret_access_key: 'an-aws-secret-access-key',
    }
  }
  let(:hostname) { "sellingpartnerapi-na.amazon.com" }
  let(:amazon_order_id) { "123-1234567-1234567" }
  let(:amazon_marketplace_id) { "ATVPDKIKX0DER" }

  subject(:solicitations_client) { described_class.new(credentials) }

  describe "create_product_review_and_seller_feedback_solicitation" do
    it 'makes a create_product_review_and_seller_feedback_solicitation request to amazon' do
      expect(solicitations_client.create_product_review_and_seller_feedback_solicitation(amazon_order_id, amazon_marketplace_id).response_code).to eq(201)
    end
  end
end
