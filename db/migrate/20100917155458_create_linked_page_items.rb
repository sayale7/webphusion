class CreateLinkedPageItems < ActiveRecord::Migration
  def self.up
    create_table :linked_page_items do |t|
      t.integer :page_id
      t.integer :page_item_id
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :linked_page_items
  end
end
