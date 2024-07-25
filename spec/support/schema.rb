# frozen_string_literal: true

ActiveRecord::Schema.define do
  create_table :upload_links do |t|
    t.string :original_name, null: false
    t.string :content_type, null: false
    t.string :upload_status, null: false
  end
end
