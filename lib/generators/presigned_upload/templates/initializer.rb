# frozen_string_literal: true

# Use this initializer to configure PresignedUpload.
#
PresignedUpload.configure do |config|
  # Configure the storage option to define which storage service will be used.
  config.storage = :aws

  # Configure the storage_options for additional information about the choosen storage service.
  config.storage_options = {
    bucket: 'my_bucket'
  }
end
