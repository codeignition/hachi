class AddLdapConfigurations < ActiveRecord::Migration
  def change
    create_table :ldap_configurations do |t|
      t.string :host
      t.string :port
      t.string :dn
      t.string :search_base
      t.string :email
      t.string :ssh_public_key
      t.string :hachi_admin_usernames
      t.string :ldap_admin_username
      t.string :ldap_admin_password
    end
  end
end
