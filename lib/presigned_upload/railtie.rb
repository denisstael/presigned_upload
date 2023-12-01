# frozen_string_literal: true

require "rails/railtie"
require "presigned_upload/models"

module PresignedUpload
  class Railtie < Rails::Railtie # :nodoc:
    initializer "presigned_upload.initialize" do
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.extend PresignedUpload::Models
      end
    end
  end
end
