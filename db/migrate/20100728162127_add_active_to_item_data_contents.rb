class AddActiveToItemDataContents < ActiveRecord::Migration
  def self.up
    add_column :item_data_contents, :active, :boolean
  end

  def self.down
    remove_column :item_data_contents, :active
  end
end
