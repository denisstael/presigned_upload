# frozen_string_literal: true

module PresignedUpload
  # Storage module that provides a common interface for interacting with different storage adapters.
  #
  # @example
  #   class MyUploader
  #     include Storage
  #   end
  #
  #   uploader = MyUploader.new
  #   url = uploader.presigned_url('key', :put, 3600)
  #   uploader.delete_file('key')
  #
  module Storage
    # Generates a presigned URL for the specified key, HTTP method, and expiration time.
    #
    # @param [String] key The key or identifier of the file in the storage.
    # @param [Symbol] method The HTTP method for which the presigned URL is generated (e.g., :put, :get).
    # @param [Integer] expires_in The duration in seconds for which the URL is valid (default is 3600 seconds).
    #
    # @return [String] The presigned URL for the specified key and method.
    def presigned_url(key, method, expires_in = 3600)
      adapter.presigned_url(key, method, expires_in)
    end

    # Deletes the file with the specified key from the storage.
    #
    # @param [String] key The key or identifier of the file to be deleted.
    #
    def delete_file(key)
      adapter.delete_file(key)
    end

    private

    # Returns the storage adapter based on the configured storage type.
    #
    # @return [PresignedUpload::Adapter::Base] An instance of the configured storage adapter.
    def adapter
      @adapter ||= PresignedUpload.adapter_class.new
    end
  end
end
