class AddThemeContentToTheme < ActiveRecord::Migration
  def self.up
    add_column :themes, :theme_content, :text
  end

  def self.down
    remove_column :themes, :theme_content
  end
end
