class LdapConfiguration < ActiveRecord::Base
  validates_presence_of :host, :port, :dn, :search_base, :email, :ssh_public_key, :hachi_admin_usernames,
                        :ldap_admin_username, :ldap_admin_password
end