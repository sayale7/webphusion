class CreateDescriptions < ActiveRecord::Migration
  def self.up
    create_table :descriptions do |t|
      t.integer :descriptionable_id
      t.string :descriptionable_type
      t.text :content
      t.string :language

      t.timestamps
    end
  end

  def self.down
    drop_table :descriptions
  end
end
