class PageItems < ActiveRecord::Migration
  def self.up
	  create_table :page_items do |t|
      t.string :name
      t.string :language

      t.timestamps
    end
  end

  def self.down
		drop_table :page_items
  end
end
