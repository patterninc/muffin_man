# frozen_string_literal: true

module MuffinMan
  module AplusContent
    class V20201101 < SpApiClient
      # Create content document
      #
      # This API is used to upload A+ Content documents.
      # The content document is the container for all A+ modules in a specific language.
      # It is required for creating content in A+ Content Manager.
      # @param marketplace_id The identifier for the marketplace where the A+ Content is published.
      # @param content_document_payload The content document request payload.
      # Refer to the A+ Content API documentation for more information.
      # @return [Hash]
      #   The response from the API, which includes the signed upload URL and additional metadata.
      # @raise [StandardError]
      #   Raises an error if the API request fails.
      #
      # @example
      #   client = MuffinMan::AplusContent::V20201101.new
      #   response = client.create_content_documents(
      #     "ATVPDKIKX0DER",
      #     { "contentDocument" => {
      #        "name" => "My Content Document",
      #        "contentType" => "STANDARD",
      #        "locale" => "en_US",
      #        "contentModuleList" => "< ContentModule > array"
      #        }
      #     }
      #   )
      #   puts response
      def create_content_documents(marketplace_id, content_document_payload)
        @local_var_path = "/aplus/2020-11-01/contentDocuments"
        @query_params = { "marketplaceId" => marketplace_id }
        @request_body = content_document_payload
        @request_type = "POST"

        call_api
      end

      # Create content document asin relations
      #
      # This API is used to associate ASINs with a content document.
      # The content document is the container for all A+ modules in a specific language.
      # It is required for creating content in A+ Content Manager.
      # @param marketplace_id The identifier for the marketplace where the A+ Content is published.
      # @param content_reference_key The unique reference key for the content document.
      # @param asin_set The set of ASINs.
      # @return [Hash]
      #   The response from the API, which includes the signed upload URL and additional metadata.
      # @raise [StandardError]
      #   Raises an error if the API request fails.
      #
      # @example
      #   client = MuffinMan::AplusContent::V20201101.new
      #   response = client.post_content_document_asin_relations(
      #     "ATVPDKIKX0DER",
      #     "contentReferenceKey",
      #     ["B07H8QMZWV", "B07H8QMZWV"]
      #   )
      #   puts response
      def post_content_document_asin_relations(marketplace_id, content_reference_key, asin_set)
        @local_var_path = "/aplus/2020-11-01/contentDocuments/#{content_reference_key}/asins"
        @query_params = { "marketplaceId" => marketplace_id }
        @request_body = { "asinSet" => asin_set }
        @request_type = "POST"

        call_api
      end

      # validate content document asin relations
      #
      # This API is used to validate the content document ASINs.
      # The content document is the container for all A+ modules in a specific language.
      # It is required for creating content in A+ Content Manager.
      # @param marketplace_id The identifier for the marketplace where the A+ Content is published.
      # @param asin_set The set of ASINs.
      # @param content_document_payload The content document request payload.
      # Refer to the A+ Content API documentation for more information.
      # @return [Hash]
      #   The response from the API, which includes the signed upload URL and additional metadata.
      # @raise [StandardError]
      #   Raises an error if the API request fails.
      #
      # @example
      #   client = MuffinMan::AplusContent::V20201101.new
      #   response = client.validate_content_document_asin_relations(
      #     "ATVPDKIKX0DER",
      #     ["B07H8QMZWV", "B07H8QMZWV"],
      #     { "contentDocument" => {
      #        "name" => "My Content Document",
      #        "contentType" => "STANDARD",
      #        "locale" => "en_US",
      #        "contentModuleList" => "< ContentModule > array"
      #        }
      #     }
      #   )
      #   puts response
      def validate_content_document_asin_relations(marketplace_id, asin_set, content_document_payload)
        @local_var_path = "/aplus/2020-11-01/contentAsinValidations"
        @query_params = { "marketplaceId" => marketplace_id, "asinSet" => asin_set.join(",") }
        @request_body = content_document_payload
        @request_type = "POST"

        call_api
      end

      # Post content document approval submission
      #
      # This API is used to submit an A+ Content document for review, approval, and publishing.
      # Moves the content document from DRAFT to SUBMITTED; Amazon then approves or rejects it.
      # @param marketplace_id The identifier for the marketplace where the A+ Content is published.
      # @param content_reference_key The unique reference key for the content document.
      # @return [Hash]
      #   The response from the API, which includes any warnings.
      # @raise [StandardError]
      #   Raises an error if the API request fails.
      #
      # @example
      #   client = MuffinMan::AplusContent::V20201101.new
      #   response = client.post_content_document_approval_submission(
      #     "ATVPDKIKX0DER",
      #     "contentReferenceKey"
      #   )
      #   puts response
      def post_content_document_approval_submission(marketplace_id, content_reference_key)
        @local_var_path = "/aplus/2020-11-01/contentDocuments/#{content_reference_key}/approvalSubmissions"
        @query_params = { "marketplaceId" => marketplace_id }
        # No request body; reset it so a body from a previous call on this client isn't resent.
        @request_body = nil
        @request_type = "POST"

        call_api
      end

      # Create media
      #
      # Registers an uploaded file as an A+ media asset. Video modules reference media by mediaId
      # (videoMediaId / imageMediaId), not by uploadDestinationId. Upload the file first with the Uploads API
      # (resource aplus/2020-11-01/contentDocuments), then pass its uploadDestinationId here.
      # A VIDEO needs descriptions and exactly one VIDEO_PAIRING relatedMedia entry (its thumbnail image).
      # Idempotent: 201 when created, 200 when identical metadata already exists, 409 when metadata differs.
      # The media library belongs to the selling account, so there is no marketplaceId.
      # @param create_media_request The CreateMediaRequest body.
      # @return [Typhoeus::Response] The unified Media shape (mediaId, status, relatedMedia, issues).
      #
      # @example
      #   client = MuffinMan::AplusContent::V20201101.new
      #   response = client.create_media(
      #     {
      #       "mediaType" => "VIDEO",
      #       "uploadDestinationId" => "aplus-media-library-service-media-upload/video.mp4",
      #       "descriptions" => [{ "locale" => "en-US", "value" => "A demonstration of the product." }],
      #       "relatedMedia" => [{
      #         "associationType" => "VIDEO_PAIRING",
      #         "title" => "Product Demo Video",
      #         "media" => { "mediaType" => "IMAGE", "uploadDestinationId" => "aplus-media/sc/thumbnail.jpg" }
      #       }]
      #     }
      #   )
      def create_media(create_media_request)
        @local_var_path = "/aplus/2020-11-01/media"
        @query_params = {}
        @request_body = create_media_request
        @request_type = "POST"

        call_api
      end

      # Get media
      #
      # Returns a media asset's metadata, status and related media. Video processing and moderation can take
      # up to 48 hours; poll this until the status is AVAILABLE (or UNABLE_TO_PROCESS / NOT_APPROVED).
      # mediaUrl is temporary, so re-read it instead of caching it.
      # @param media_id The media asset identifier returned by create_media.
      # @param associated_media_id Optional; limits relatedMedia to one pairing.
      # @return [Typhoeus::Response] The unified Media shape.
      #
      # @example
      #   client = MuffinMan::AplusContent::V20201101.new
      #   response = client.get_media("b2c3d4e5-f6a7-8901-bcde-f12345678901")
      def get_media(media_id, associated_media_id: nil)
        @local_var_path = "/aplus/2020-11-01/media/#{media_id}"
        @query_params = {}
        @query_params["associatedMediaId"] = associated_media_id if associated_media_id
        @request_body = nil
        @request_type = "GET"

        call_api
      end
    end
  end
end
