class Create<%= model_name.camelize.pluralize %> < ActiveRecord::Migration[7.0]
  def change
    create_table :<%= model_name.underscore.pluralize + migration_id_column %> do |t|
      t.string :original_name, null: false
      t.string :content_type, null: false
      t.string :upload_status, null: false

      t.timestamps
    end
  end
end
