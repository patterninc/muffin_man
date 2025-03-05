# frozen_string_literal: true

RSpec.describe MuffinMan::ListingsRestrictions::V20210801 do
  subject(:listings_redictions_client) { described_class.new(credentials) }

  before do
    stub_request_access_token
  end

  let(:seller_id) { "AXXXXXXXXXXX" }
  let(:asin) { "B08XXLG119" }
  let(:amazon_marketplace_id) { "ATVPDKIKX0DER" }
  let(:reason_locale) { "en_US" }
  let(:condition_type) { "new_new" }

  describe "get_listings_restrictions" do
    it "get listing restrictions for restricted asin" do
      stub_get_listings_restricted
      listings_restrictions =
        listings_redictions_client.get_listings_restrictions(asin, seller_id,
                                                             amazon_marketplace_id, condition_type)
      expect(listings_restrictions.response_code).to eq(200)
      expect(JSON.parse(listings_restrictions.body)["restrictions"]).to be_present
    end

    it "get listing restrictions for unrestricted asin" do
      stub_get_listings_unrestricted
      listings_restrictions =
        listings_redictions_client.get_listings_restrictions(asin, seller_id,
                                                             amazon_marketplace_id, condition_type)
      expect(listings_restrictions.response_code).to eq(200)
      expect(JSON.parse(listings_restrictions.body)["restrictions"]).to eq([{}])
    end
  end
end
