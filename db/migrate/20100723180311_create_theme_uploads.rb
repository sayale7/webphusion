class CreateThemeUploads < ActiveRecord::Migration
  def self.up
    create_table :theme_uploads do |t|
      t.integer :theme_id

      t.timestamps
    end
  end

  def self.down
    drop_table :theme_uploads
  end
end
