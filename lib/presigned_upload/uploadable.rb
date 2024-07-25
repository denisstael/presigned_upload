# frozen_string_literal: true

require "presigned_upload/storage"
require "active_support/concern"

module PresignedUpload
  #
  # The `Uploadable` module integrates storage functionality with a model, allowing handling
  # file uploads and associated storage operations. It includes the capabilities provided by the
  # `PresignedUpload::Storage` module.
  #
  # This module is designed to be included in ActiveRecord models to facilitate common file upload
  # operations, such as generating presigned URLs, deleting stored files, and managing upload status.
  #
  # @example
  #
  #   class MyUploadableModel < ApplicationRecord
  #     include Uploadable::Model
  #   end
  #
  #   model = MyUploadableModel.new(original_name: 'example.txt', content_type: 'text/plain', upload_status: :initial)
  #   model.upload_url # Generates a presigned URL for file upload.
  #   model.url        # Retrieves a presigned URL for accessing the stored file.
  #
  # @see PresignedUpload::Storage
  module Uploadable
    include PresignedUpload::Storage

    # The `Model` submodule extends ActiveSupport::Concern to provide upload-related functionality
    # to ActiveRecord models.
    module Model
      extend ActiveSupport::Concern

      include Uploadable

      included do
        validates :original_name, :content_type, :upload_status, presence: true

        enum upload_status: { initial: "initial", completed: "completed" }

        after_destroy { delete_stored_file }
      end

      # Returns a presigned URL for accessing the stored file. Returns `nil` if the upload status is not 'completed'.
      #
      # @return [String, nil] The presigned URL for accessing the stored file or `nil` if the
      #   upload status is not completed.
      #
      def url
        return unless completed?

        presigned_url(store_path, :get)
      end

      # Returns a presigned URL for uploading the file. Returns `nil` if the upload status is 'completed'.
      #
      # @return [String, nil] The presigned URL for uploading the file or `nil` if the upload status is
      #   already marked as completed.
      #
      def upload_url
        return if completed?

        presigned_url(store_path, :put)
      end

      # Deletes the stored file associated with the model.
      #
      def delete_stored_file
        delete_file(store_path)
      end

      # Returns the file store path.
      #
      # The store path is constructed by combining the storage directory
      #   with the `original_name` of the file. If `store_dir` is present, it is
      #   included in the path. If `store_dir` is not present, then the file
      #   will be saved in the root directory.
      #
      # @return [String] the storage path for the uploaded file.
      def store_path
        "#{store_dir.present? ? "#{store_dir}/" : ""}#{original_name}"
      end
    end
  end
end
