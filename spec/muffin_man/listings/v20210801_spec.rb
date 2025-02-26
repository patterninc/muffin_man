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
    context "when creating or updating a full listing item" do
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

      it "returns an ACCEPTED status" do
        response = listings_client.put_listings_item(seller_id, sku, amazon_marketplace_id, product_type, attributes,
                                                     requirements: requirements)
        expect(response.response_code).to eq(200)
        expect(JSON.parse(response.body)).to eq(submission_accepted_response)
      end
    end

    context "when previewing validation for a listings item" do
      before { stub_put_listings_item_preview }

      let(:requirements) { "LISTING_OFFER_ONLY" }
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
          ],
          identifiers: [
            {
              asin: "B987654321",
              marketplaceId: "ATVPDKIKX0DER"
            }
          ]
        }
      end

      #     PUT https://sellingpartnerapi-na.amazon.com/listings/2021-08-01/items/AXXXXXXXXXXXXX/ABC123
      # ?marketplaceIds=ATVPDKIKX0DER
      # &issueLocale=en_US
      # &mode=VALIDATION_PREVIEW
      # &includedData=issues,identifiers

      it "returns a VALIDATED status" do
        response = listings_client.put_listings_item(seller_id, sku,
                                                     amazon_marketplace_id, product_type, attributes,
                                                     requirements: requirements, mode: "VALIDATION_PREVIEW",
                                                     included_data: ["issues", "identifiers"], issue_locale: "en_US")
        expect(response.response_code).to eq(200)
        expect(JSON.parse(response.body)["status"]).to eq("VALID")
      end
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

  describe "search_listings_items" do
    let(:optional_query) do
      { identifiers: "XXXXXXXXX,YYYYYYYY,ZZZZZZZZ",
        identifiers_type: "SKU",
        included_data: ["issues", "attributes", "summaries"],
        issueLocale: "en_US",
        page_size: 20 }
    end

    it "makes a simple request to search listings items" do
      stub_search_listings_item
      response = listings_client.search_listings_items(seller_id, amazon_marketplace_id)
      expect(response.response_code).to eq(200)
      expect(JSON.parse(response.body)["items"][0]["sku"]).to eq("GM-ZDPI-9B4E")
    end

    it "makes a complex request to search listings items" do
      stub_search_listings_item_query
      response = listings_client.search_listings_items(seller_id, amazon_marketplace_id, **optional_query)
      expect(response.response_code).to eq(200)
    end
  end
end
