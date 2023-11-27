# frozen_string_literal: true

require "rails/generators"
require "rails/generators/active_record"

module PresignedUpload
  class UploadableModelGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    source_root File.expand_path("templates", __dir__)

    argument :model_name, type: :string, desc: "Name of presigned uploadable model"
    class_option :uuid, type: :boolean, default: false, desc: "Use UUID type for primary key"

    def self.next_migration_number(path)
      ActiveRecord::Generators::Base.next_migration_number(path)
    end

    def create_model_and_migration
      generate_model
      generate_migration
    end

    private

    def generate_model
      template "uploadable_model.rb", File.join("app", "models", "#{model_name.underscore}.rb")
    end

    def migration_id_column
      options.uuid? ? ", id: :uuid" : ""
    end

    def generate_migration
      migration_template "migration.rb", "db/migrate/create_#{model_name.underscore.pluralize}.rb"
    end
  end
end
