# frozen_string_literal: true

require "presigned_upload/railtie"
require "presigned_upload/version"

# The `PresignedUpload` module serves as the main module for the presigned file upload functionality.
# It provides configuration options, such as storage type and configuration settings.
#
module PresignedUpload
  class << self
    attr_accessor :storage
    attr_writer :storage_config

    def configure
      yield self
    end

    # Returns the current storage configuration or an empty hash if not set.
    #
    # @return [Hash] The storage configuration.
    def storage_config
      @storage_config || {}
    end
  end
end
