class AddPageKindToPage < ActiveRecord::Migration
  def self.up
    add_column :pages, :page_kind, :string
  end

  def self.down
    remove_column :pages, :page_kind
  end
end
