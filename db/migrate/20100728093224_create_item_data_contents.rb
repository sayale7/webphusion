class CreateItemDataContents < ActiveRecord::Migration
  def self.up
    create_table :item_data_contents do |t|
      t.integer :item_id
      t.string :name
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :item_data_contents
  end
end
