class CreateLocalizables < ActiveRecord::Migration
  def self.up
    create_table :localizables do |t|
      t.string :localizable_type
      t.integer :localizable_id
      t.integer :language_id

      t.timestamps
    end
  end

  def self.down
    drop_table :localizables
  end
end
