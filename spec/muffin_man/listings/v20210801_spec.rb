# frozen_string_literal: true

RSpec.describe MuffinMan::Listings::V20210801 do
  subject(:listings_client) { described_class.new(credentials) }

  before do
    stub_request_access_token
  end

  let(:sku) { "SD-ABC-12345" }
  let(:seller_id) { "THE_MUFFIN_MAN" }
  let(:amazon_marketplace_id) { "DRURYLANE" }
  let(:issue_locale) { "en_US" }

  describe "get_listings_item" do
    before { stub_get_listings_item }

    it "makes a request to get a listings item" do
      expect(listings_client.get_listings_item(seller_id, sku, amazon_marketplace_id).response_code).to eq(200)
      expect(JSON.parse(listings_client.get_listings_item(seller_id, sku,
                                                          amazon_marketplace_id).body)["sku"]).to eq(sku)
    end
  end

  describe "put_listings_item" do
    before { stub_put_listings_item }

    let(:product_type) { "LUGGAGE" }
    let(:requirements) { "LISTING" }
    let(:attributes) do
      {
        condition_type:
          {
            value: "new_new",
            marketplace_id: "ATVPDKIKX0DER"
          },
        item_name:
          {
            value: 'AmazonBasics 16\" Underseat Spinner Carry-On',
            language_tag: "en_US",
            marketplace_id: "ATVPDKIKX0DER"
          }
      }
    end

    let(:put_listing_result) do
      {
        "sku" => "SD-ABC-12345",
        "status" => "ACCEPTED",
        "submissionId" => "f1dc2914-75dd-11ea-bc55-0242ac130003",
        "issues" => []
      }
    end

    it "makes a request to create a listings item or update an existing listings item" do
      response = listings_client.put_listings_item(seller_id, sku, amazon_marketplace_id, product_type, attributes,
                                                   requirements: requirements)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)).to eq(put_listing_result)
    end
  end

  describe "delete_listings_item" do
    context "when sku and seller_id combination is correct" do
      before { stub_delete_listings_item }

      let(:delete_listing_result) do
        {
          "sku" => "SD-ABC-12345",
          "status" => "ACCEPTED",
          "submissionId" => "f1dc2914-75dd-11ea-bc55-0242ac130003",
          "issues" => []
        }
      end

      it "makes a request to delete a listings item" do
        response = listings_client.delete_listings_item(seller_id, sku, amazon_marketplace_id,
                                                        issue_locale: issue_locale)
        expect(response.response_code).to eq(200)
        expect(JSON.parse(response.body)).to eq(delete_listing_result)
      end
    end

    context "when sku and seller_id combination is not found" do
      before { stub_delete_listings_item_wrong_sku }

      let(:nonexistent_sku) { "SD-XYZ-98765" }

      it "returns a 'not found' response" do
        response = listings_client.delete_listings_item(seller_id, nonexistent_sku, amazon_marketplace_id,
                                                        issue_locale: issue_locale)
        expect(response.response_code).to eq(404)
      end
    end
  end
end
