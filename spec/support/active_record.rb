# frozen_string_literal: true

require "active_record"
require "presigned_upload/models"

# rubocop:disable Style/Documentation

class UploadLink < ActiveRecord::Base
  extend PresignedUpload::Models

  private

  def generate_store_path
    "generated_store_path"
  end
end

# rubocop:enable Style/Documentation
