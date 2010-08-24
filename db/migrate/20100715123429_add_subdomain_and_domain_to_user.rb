class AddSubdomainAndDomainToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :subdomain, :string
    add_column :users, :domain, :string
  end

  def self.down
    remove_column :users, :domain
    remove_column :users, :subdomain
  end
end
