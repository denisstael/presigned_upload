# frozen_string_literal: true

module PresignedUpload
  class InvalidStorage < StandardError; end
  class InvalidStorageConfig < StandardError; end
  class MissingDependency < StandardError; end
end
