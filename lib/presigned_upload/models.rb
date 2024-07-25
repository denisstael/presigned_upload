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

    # Calling this method in the context of the model class includes Uploadable::Model module, which includes
    # all the behavior from the Uploadable module and the Uploadable::Model, including validations and callbacks
    #
    # @param [Hash] options Options hash
    # @option options [Symbol] :store_dir The path to the storage location directory
    #   Accepts a Symbol value, which will try to call a method with same name
    #   in model, a String value representing the store directory or a Proc to call
    #
    # @example
    #
    #   UploadLink < ApplicationRecord
    #     presigned_uploadable_model, store_dir: :generate_store_dir
    #   end
    #
    def presigned_uploadable_model(options = {})
      include Uploadable::Model

      store_dir = options[:store_dir]

      define_method :store_dir do
        case store_dir
        when Symbol
          __send__(store_dir)
        when String
          store_dir
        when Proc
          instance_exec(&store_dir)
        else
          "uploads/#{model_name.plural}/#{id}"
        end
      end
    end
    # rubocop:enable Metrics/MethodLength
  end
end
