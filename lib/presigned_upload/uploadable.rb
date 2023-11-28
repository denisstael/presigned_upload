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
        attr_readonly :original_name, :content_type, :store_path

        validates :original_name, :content_type, :upload_status, presence: true

        enum upload_status: { initial: "initial", completed: "completed" }

        after_destroy { delete_stored_file }
      end

      # Returns a presigned URL for accessing the stored file. Returns `nil` if the upload status is 'initial'.
      #
      # @return [String, nil] The presigned URL for accessing the stored file or `nil` if the
      #   upload status is initial.
      #
      def url
        return if initial?

        presigned_url(store_path, :get)
      end

      # Returns a presigned URL for uploading the file. Returns `nil` if the store path is blank or the
      # upload status is 'completed'.
      #
      # @return [String, nil] The presigned URL for uploading the file or `nil` if the upload status is
      #   'completed' or store path is not present.
      #
      def upload_url
        return if store_path.blank? || completed?

        presigned_url(store_path, :put)
      end

      # Deletes the stored file associated with the model.
      #
      def delete_stored_file
        delete_file(store_path)
      end
    end
  end
end
