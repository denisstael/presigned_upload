# frozen_string_literal: true

module PresignedUpload
  #
  # Configuration class
  #
  class Configuration
    AVAILABLE_STORAGES = [:aws].freeze

    attr_accessor :storage, :storage_options
    attr_reader :adapter_class

    def initialize
      @storage = nil
      @storage_options = {}
    end

    def configure!
      unless AVAILABLE_STORAGES.include?(storage)
        raise InvalidStorage, "Invalid storage option. Allowed types are: #{AVAILABLE_STORAGES}"
      end

      raise InvalidStorageConfig, "Empty storage options configuration" if storage_options.empty?

      case storage
      when :aws
        load_aws
      end

      self
    end

    private

    def load_aws
      require_aws_dependencies!

      required_config_keys = [:bucket]
      storage_options.each_key { |key| storage_options.except!(key) unless required_config_keys.include?(key) }

      unless required_config_keys.all? { |key| storage_options.key?(key) }
        raise InvalidStorageConfig, "Missing storage configuration. Required keys are: #{required_config_keys}"
      end

      @adapter_class = PresignedUpload::Adapter::Aws
    end

    def require_aws_dependencies!
      unless defined?(::Aws::S3)
        raise MissingDependency, "Missing required dependency\n
            PresignedUpload requires 'aws-sdk-s3' gem to work properly with Aws S3 storage.\n
            To fix this error, consider adding [gem 'aws-sdk-s3'] into your Gemfile."
      end

      require "presigned_upload/adapter/aws"
    end
  end
end
