class AddOrganizationalAttributesToUser < ActiveRecord::Migration
  def change
    add_column :users, :dn, :integer
    add_column :users, :ssh_public_key, :string
  end
end
