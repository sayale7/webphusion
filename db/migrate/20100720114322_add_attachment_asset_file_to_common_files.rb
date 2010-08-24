class AddAttachmentAssetToCommonFile < ActiveRecord::Migration
  def self.up
    add_column :common_file, :common_file_asset_file_file_name, :string
    add_column :common_file, :common_file_asset_file_content_type, :string
    add_column :common_file, :common_file_asset_file_file_size, :integer
    add_column :common_file, :common_file_asset_file_updated_at, :datetime
  end

  def self.down
    remove_column :common_file, :common_file_asset_file_file_name
    remove_column :common_file, :common_file_asset_file_content_type
    remove_column :common_file, :common_file_asset_file_file_size
    remove_column :common_file, :common_file_asset_file_updated_at
  end
end
