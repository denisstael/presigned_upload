# frozen_string_literal: true

require "rails/generators"

module PresignedUpload
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("templates", __dir__)

    def generate_initializer
      template "initializer.rb", "config/initializers/presigned_upload.rb"
    end
  end
end
