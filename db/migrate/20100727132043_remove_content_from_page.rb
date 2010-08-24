class RemoveContentFromPage < ActiveRecord::Migration
  def self.up
    remove_column :pages, :content
  end

  def self.down
    add_column :pages, :content, :text
  end
end
