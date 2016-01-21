require 'net/ldap'

# Ldap Users is a collection of users on Local Directory Access Protocol

class LdapUsers
  COMMON_NAME = 'cn'
  def initialize
    @ldap = Net::LDAP.new(
      :host => APP_CONFIG['ldap_host'],
      :port => APP_CONFIG['ldap_port'],
      :auth => {
        :method => :simple,
        :username =>  APP_CONFIG['ldap_admin_username'],
        :password =>  APP_CONFIG['ldap_admin_password']
      }
    )
  end

  def find_by_common_name(common_name)
    filter_condition = Net::LDAP::Filter.eq(COMMON_NAME, common_name)
    begin
      @ldap.search(:base => APP_CONFIG['ldap_treebase'], :filter => filter_condition) do |ldap_entry|
        common_name = ldap_entry.cn.first
        return User.new(name: common_name, email: common_name + '@'+APP_CONFIG['ldap_dc'])
      end
    rescue Net::LDAP::ConnectionRefusedError
    end
    nil
  end
end
