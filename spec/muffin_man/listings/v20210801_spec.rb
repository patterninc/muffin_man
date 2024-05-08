# frozen_string_literal: true

RSpec.describe MuffinMan::Listings::V20210801 do
  subject(:listings_client) { described_class.new(credentials) }

  before do
    stub_request_access_token
  end

  let(:seller_id) { "THE_MUFFIN_MAN" }
  let(:sku) { "SD-ABC-12345" }
  let(:amazon_marketplace_id) { "DRURYLANE" }
  let(:issue_locale) { "en_US" }
  let(:product_type) { "LUGGAGE" }
  let(:submission_accepted_response) do
    {
      "sku" => "SD-ABC-12345",
      "status" => "ACCEPTED",
      "submissionId" => "f1dc2914-75dd-11ea-bc55-0242ac130003",
      "issues" => []
    }
  end

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

    let(:requirements) { "LISTING" }
    let(:attributes) do
      {
        condition_type: [
          {
            value: "new_new",
            marketplace_id: "ATVPDKIKX0DER"
          }
        ],
        item_name: [
          {
            value: "AmazonBasics 16\" Underseat Spinner Carry-On",
            language_tag: "en_US",
            marketplace_id: "ATVPDKIKX0DER"
          }
        ]
      }
    end

    it "makes a request to create a listings item or update an existing listings item" do
      response = listings_client.put_listings_item(seller_id, sku, amazon_marketplace_id, product_type, attributes,
                                                   requirements: requirements)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)).to eq(submission_accepted_response)
    end
  end

  describe "delete_listings_item" do
    context "when sku and seller_id combination is correct" do
      before { stub_delete_listings_item }

      it "makes a request to delete a listings item" do
        response = listings_client.delete_listings_item(seller_id, sku, amazon_marketplace_id,
                                                        issue_locale: issue_locale)
        expect(response.response_code).to eq(200)
        expect(JSON.parse(response.body)).to eq(submission_accepted_response)
      end
    end

    context "when sku and seller_id combination is not found" do
      before { stub_delete_listings_item_nonexistent_sku }

      let(:nonexistent_sku) { "SD-XYZ-98765" }

      it "returns a 'not found' response" do
        response = listings_client.delete_listings_item(seller_id, nonexistent_sku, amazon_marketplace_id,
                                                        issue_locale: issue_locale)
        expect(response.response_code).to eq(404)
      end
    end
  end

  describe "patch_listings_item" do
    before { stub_patch_listings_item }

    let(:patches) do
      [
        {
          op: "replace",
          path: "/attributes/item_name",
          value: {
            value: "AmazonBasics 16\" Underseat Spinner Carry-On",
            language_tag: "en_US",
            marketplace_id: "ATVPDKIKX0DER"
          }
        }
      ]
    end

    it "makes a request to patch a listings item" do
      response = listings_client.patch_listings_item(seller_id, sku, amazon_marketplace_id, product_type, patches)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)).to eq(submission_accepted_response)
    end
  end
end
