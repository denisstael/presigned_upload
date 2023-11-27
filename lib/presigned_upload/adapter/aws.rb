# frozen_string_literal: true

require "presigned_upload/adapter/base"

module PresignedUpload
  module Adapter
    #
    # The `Aws` class is an adapter for interacting with the Amazon Simple Storage Service (S3) using the AWS SDK.
    # It inherits from `Adapter::Base` and implements methods for generating presigned URLs, uploading files,
    # and deleting files.
    #
    # @see Adapter::Base
    class Aws < Base
      #
      # Generates a presigned URL for the specified key, HTTP method, and expiration time.
      #
      # @param [String] key The key or identifier of the file in the storage.
      # @param [Symbol] method The HTTP method for which the presigned URL is generated (e.g., :put, :get).
      # @param [Integer] expires_in The duration in seconds for which the URL is valid.
      #
      # @return [String] The presigned URL for the specified key, method, and expiration time.
      def presigned_url(key, method, expires_in)
        bucket.object(key).presigned_url(method, expires_in: expires_in)
      end

      # Uploads the specified file to the storage with the given key.
      #
      # @param [String] file The path to the local file to be uploaded.
      # @param [String] key The key or identifier for the file in the storage.
      #
      # @return [void]
      def upload_file(file, key)
        object = bucket.object(key)
        object.upload_file(file)
      end

      # Deletes the file with the specified key from the storage.
      #
      # @param [String] key The key or identifier of the file to be deleted.
      #
      # @return [void]
      def delete_file(key)
        bucket.object(key).delete
      end

      private

      # Returns the AWS S3 client for interacting with the service.
      #
      # @return [Aws::S3::Client] The AWS S3 client.
      def client
        @client ||= ::Aws::S3::Client.new
      end

      # Returns the AWS S3 resource for interacting with S3 objects and buckets.
      #
      # @return [Aws::S3::Resource] The AWS S3 resource.
      def resource
        @resource ||= ::Aws::S3::Resource.new
      end

      # Returns the name of the S3 bucket configured for storage.
      #
      # @return [String] The name of the S3 bucket.
      def bucket_name
        @bucket_name ||= storage_config[:bucket]
      end

      # Returns the S3 bucket resource for the configured bucket name.
      #
      # @return [Aws::S3::Bucket] The S3 bucket resource.
      def bucket
        @bucket ||= resource.bucket(bucket_name)
      end
    end
  end
end
