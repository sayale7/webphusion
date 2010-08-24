class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :common_files do |t|
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :common_files
  end
end
