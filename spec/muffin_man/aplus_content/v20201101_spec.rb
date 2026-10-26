# frozen_string_literal: true

RSpec.describe MuffinMan::AplusContent::V20201101 do
  subject(:aplus_content_client) { described_class.new(credentials) }

  before do
    stub_request_access_token
    stub_create_content_documents
    stub_post_content_document_asin_relations
    stub_validate_content_document_asin
    stub_post_content_document_approval_submission
    stub_create_media
    stub_get_media
    stub_get_media_for_pairing
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
  let(:video_media_id) { "b2c3d4e5-f6a7-8901-bcde-f12345678901" }
  let(:image_media_id) { "c3d4e5f6-a7b8-9012-cdef-234567890123" }
  let(:create_media_request) do
    {
      "mediaType" => "VIDEO",
      "uploadDestinationId" => "aplus-media-library-service-media-upload/video.mp4",
      "descriptions" => [{ "locale" => "en-US", "value" => "A demonstration of the product." }],
      "relatedMedia" => [{
        "associationType" => "VIDEO_PAIRING",
        "title" => "Product Demo Video",
        "media" => { "mediaType" => "IMAGE", "uploadDestinationId" => "aplus-media/sc/thumbnail.jpg" }
      }]
    }
  end

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

  describe "#post_content_document_approval_submission" do
    it "submits the content document for approval" do
      response = aplus_content_client.post_content_document_approval_submission(marketplace_id,
                                                                                content_reference_key)
      expect(response.code).to eq(200)
    end

    it "does not resend the body of a previous call on the same client" do
      aplus_content_client.post_content_document_asin_relations(marketplace_id, content_reference_key, asin_set)
      response = aplus_content_client.post_content_document_approval_submission(marketplace_id,
                                                                                content_reference_key)
      expect(response.code).to eq(200)
    end
  end

  describe "#create_media" do
    it "registers an uploaded video with its thumbnail, without a marketplaceId" do
      response = aplus_content_client.create_media(create_media_request)
      expect(response.code).to eq(201)
      expect(JSON.parse(response.body)["mediaId"]).to eq(video_media_id)
    end

    it "does not send query params left over from a previous call on the same client" do
      aplus_content_client.post_content_document_approval_submission(marketplace_id, content_reference_key)
      response = aplus_content_client.create_media(create_media_request)
      expect(response.code).to eq(201)
    end
  end

  describe "#get_media" do
    it "reads the media status without a request body" do
      aplus_content_client.create_media(create_media_request)
      response = aplus_content_client.get_media(video_media_id)
      expect(JSON.parse(response.body)["status"]).to eq(["AVAILABLE"])
    end

    it "filters to one pairing with associated_media_id" do
      response = aplus_content_client.get_media(video_media_id, associated_media_id: image_media_id)
      expect(response.code).to eq(200)
    end
  end
end
