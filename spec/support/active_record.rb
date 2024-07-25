# frozen_string_literal: true

require "active_record"
require "presigned_upload/models"

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
ActiveRecord::Base.extend PresignedUpload::Models

load "#{File.dirname(__FILE__)}/schema.rb"

class UploadLink < ActiveRecord::Base
  private

  def generate_store_dir
    "generated/store/dir"
  end
end
