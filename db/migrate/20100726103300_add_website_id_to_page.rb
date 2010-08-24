class AddWebsiteIdToPage < ActiveRecord::Migration
  def self.up
    add_column :pages, :website_id, :integer
  end

  def self.down
    remove_column :pages, :website_id
  end
end
