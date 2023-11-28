# frozen_string_literal: true

module PresignedUpload
  #
  # Configuration class
  #
  class Configuration
    AVAILABLE_STORAGES = [:aws].freeze

    attr_accessor :storage, :storage_config

    def initialize
      @storage = nil
      @storage_config = {}
    end

    def configure!
      unless AVAILABLE_STORAGES.include?(@storage)
        raise InvalidStorage, "Invalid storage. Allowed types are: #{AVAILABLE_STORAGES}"
      end

      raise InvalidStorageConfig, "Empty storage configuration" if @storage_config.empty?

      case @storage
      when :aws
        load_aws
      end

      self
    end

    private

    def load_aws
      require_aws_dependencies!

      required_config_keys = [:bucket]
      unless required_config_keys.all? { |key| @storage_config.key?(key) }
        raise InvalidStorageConfig, "Missing storage configuration. Required keys are: #{required_config_keys}"
      end

      @storage_config.each_key { |key| @storage_config.except!(key) unless required_config_keys.include?(key) }
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
