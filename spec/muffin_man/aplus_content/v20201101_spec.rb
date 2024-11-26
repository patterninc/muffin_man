# frozen_string_literal: true

RSpec.describe MuffinMan::AplusContent::V20201101 do
  subject(:aplus_content_client) { described_class.new(credentials) }

  before do
    stub_request_access_token
    stub_create_content_documents
    stub_post_content_document_asin_relations
    stub_validate_content_document_asin
  end

  let(:marketplace_id) { "ATVPDKIKX0DER" }
  let(:content_document_payload) do
    {
      "contentDocument" => {
        "name" => "My Content Document",
        "contentType" => "STANDARD",
        "locale" => "en_US",
        "contentModuleList" => [
          {
            contentModuleType: "STANDARD_COMPANY_LOGO",
            standardCompanyLogo: {
              companyLogo: {
                altText: "Testing LOGO",
                imageCropSpecification: {
                  size: {
                    height: {
                      units: "pixels",
                      value: "180"
                    },
                    width: {
                      units: "pixels",
                      value: "600"
                    }
                  }
                },
                uploadDestinationId: "aplus-media/sc/3cc19c38-7f3f-4a4d-b18b-b37801c06ec5.jpg"
              }
            }
          },
          {
            contentModuleType: "STANDARD_TEXT",
            standardText: {
              body: {
                textList: [
                  {
                    value: "Text to be displayed in description"
                  }
                ]
              },
              headline: {
                value: "Lorem ipsum odor amet, consectetuer adipiscing elit."
              }
            }
          }
        ]
      }
    }
  end
  let(:content_reference_key) { "contentReferenceKey" }
  let(:asin_set) { ["B07H8QMZWV", "B07H8QMZWV"] }

  describe "#create_content_documents" do
    it "creates a content document" do
      response = aplus_content_client.create_content_documents(marketplace_id, content_document_payload)
      expect(response.code).to eq(200)
    end
  end

  describe "#post_content_document_asin_relations" do
    it "associates ASINs with a content document" do
      response = aplus_content_client.post_content_document_asin_relations(marketplace_id, content_reference_key,
                                                                           asin_set)
      expect(response.code).to eq(200)
    end
  end

  describe "#validate_content_document_asin_relations" do
    it "validates the content document ASINs" do
      response = aplus_content_client.validate_content_document_asin_relations(marketplace_id, asin_set,
                                                                               content_document_payload)
      expect(response.code).to eq(200)
    end
  end
end
