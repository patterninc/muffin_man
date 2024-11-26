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
    end
  end
end
