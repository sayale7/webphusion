class CreateThemeItems < ActiveRecord::Migration
  def self.up
    create_table :theme_items do |t|
      t.integer :theme_id
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :theme_items
  end
end
