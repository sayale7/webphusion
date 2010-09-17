class AddLongLanguageToLanguage < ActiveRecord::Migration
  def self.up
    add_column :languages, :long_language, :string
  end

  def self.down
    remove_column :languages, :long_language
  end
end
