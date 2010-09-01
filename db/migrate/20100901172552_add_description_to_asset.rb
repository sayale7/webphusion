class AddDescriptionToAsset < ActiveRecord::Migration
  def self.up
    add_column :assets, :description, :text
  end

  def self.down
    remove_column :assets, :description
  end
end
