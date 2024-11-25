module MuffinMan
  module Uploads
    class V20201101 < SpApiClient

      # Creates a new upload destination for a resource.
      #
      # This method generates a signed upload destination URL for a specific resource 
      # that you can use to upload files to Amazon SP-API.
      #
      # @param [String] marketplace_id
      #   The identifier of the marketplace for the request (e.g., 'ATVPDKIKX0DER').
      # @param [String] resource
      #   The resource type and path, such as:
      #   - `/messaging/v1/orders/{amazonOrderId}/messages/legalDisclosure`
      #   - `aplus/2020-11-01/contentDocuments`.
      # @param [String] content_md5
      #   The MD5 hash of the file's content. Use `Digest::MD5.file(file_path).hexdigest` to calculate this.
      # @param [String] content_type
      #   The MIME type of the file to be uploaded (e.g., 'application/pdf').
      # @return [Hash]
      #   The response from the API, which includes the signed upload URL and additional metadata.
      # @raise [StandardError]
      #   Raises an error if the API request fails.
      #
      # @example
      #   client = MuffinMan::Uploads::V20201101.new
      #   response = client.create_upload_destination_for_resource(
      #     "ATVPDKIKX0DER",
      #     "aplus/2020-11-01/contentDocuments",
      #     "510700ca1b152c729b62f2fd13c8dbbe",
      #     "application/pdf"
      #   )
      #   puts response
      def create_upload_destination_for_resource(marketplace_id, resource, content_md5, content_type)
        @local_var_path = "/uploads/2020-11-01/uploadDestinations/#{resource}"
        @query_params = { "marketplaceIds" => marketplace_id, "contentMD5" => content_md5, contentType: content_type }
        @request_type = "POST"

        call_api
      end
    end
  end
end
