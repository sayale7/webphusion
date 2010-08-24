class AddItemKindToThemeItem < ActiveRecord::Migration
  def self.up
    add_column :theme_items, :item_kind, :string
  end

  def self.down
    remove_column :theme_items, :item_kind
  end
end
