# frozen_string_literal: true

require "presigned_upload/uploadable"

module PresignedUpload
  #
  # Module extended by ActiveRecord::Base to allow configuring models with resources of the gem
  #
  module Models
    #
    # Calling this method in the context of the model class includes Uploadable module, which makes
    # available the methods for requesting presigned_urls and deleting file from the cloud storage
    #
    # @example:
    #
    #   UploadLink < ApplicationRecord
    #     presigned_uploadable
    #   end
    #
    #   upload_link = UploadLink.new
    #   upload_link.presigned_url('key', :get, expires_in = 3600)
    #   upload_link.delete_file('key')
    #
    def presigned_uploadable
      include Uploadable
    end

    # rubocop:disable Metrics/MethodLength
    #
    # Calling this method in the context of the model class includes Uploadable::Model module, which includes
    # all the behavior from the Uploadable module and the Uploadable::Model, including validations and callbacks
    #
    # @param [Hash] options Options hash
    # @option options [Symbol] :store_path The path to the storage location
    #   Accepts a Symbol value, which will try to call a method with same name
    #   in model, a String value representing the store path or a Proc to call
    #
    # @example
    #
    #   UploadLink < ApplicationRecord
    #     presigned_uploadable_model, store_path: :generate_store_path
    #   end
    #
    def presigned_uploadable_model(options = {})
      include Uploadable::Model

      store_path = options[:store_path]

      before_create do
        self.store_path =
          case store_path
          when Symbol
            __send__(store_path)
          when String
            store_path
          when Proc
            store_path.call
          else
            "uploads/#{model_name.plural}/#{original_name}"
          end
      end
    end
    # rubocop:enable Metrics/MethodLength
  end
end
