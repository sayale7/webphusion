class AddLocaleToItemDataContent < ActiveRecord::Migration
  def self.up
    add_column :item_data_contents, :locale, :string
  end

  def self.down
    remove_column :item_data_contents, :locale
  end
end
