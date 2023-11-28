# frozen_string_literal: true

require "presigned_upload/railtie"
require "presigned_upload/version"
require "presigned_upload/configuration"
require "presigned_upload/errors"
require "presigned_upload/adapter/base"

# The `PresignedUpload` module serves as the main module for the presigned file upload functionality.
# It provides configuration options, such as storage type and configuration settings.
#
module PresignedUpload
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new

      yield(configuration)

      configuration.configure!
    end
  end

  def self.adapter_class
    @adapter_class ||= configuration.adapter_class
  end
end
