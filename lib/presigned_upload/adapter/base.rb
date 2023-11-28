# frozen_string_literal: true

module PresignedUpload
  #
  # The `Adapter` module contains classes responsible for interfacing with different storage services.
  # Each adapter class should inherit from `PresignedUpload::Adapter::Base`.
  #
  # @see PresignedUpload::Adapter::Base
  module Adapter
    # The `Base` class serves as the base class for all storage adapters in the `PresignedUpload` module.
    # It provides a common interface for accessing storage configurations.
    #
    # @see PresignedUpload::Adapter
    class Base
      #
      # Initializes a new instance of the adapter.
      #
      def initialize
        @storage_config = PresignedUpload.configuration.storage_config
      end

      protected

      # Returns the storage configuration for the adapter.
      #
      # @return [Hash] The storage configuration.
      attr_reader :storage_config
    end
  end
end
