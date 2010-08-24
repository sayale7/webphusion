class AddCollectionIdToAsset < ActiveRecord::Migration
  def self.up
    add_column :assets, :collection_id, :integer
  end

  def self.down
    remove_column :assets, :collection_id
  end
end
