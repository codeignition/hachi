require 'net/ldap'

# Ldap Users is a collection of users on Local Directory Access Protocol

class LdapUsers
  COMMON_NAME = 'cn'
  LDAP_HOST = '192.168.33.101'
  LDAP_PORT = 389

  def initialize
    @ldap = Net::LDAP.new(
      :host => LDAP_HOST,
      :port => LDAP_PORT,
      :auth => {
          :method => :simple,
          :username => 'cn=admin,dc=c42,dc=in',
          :password => '!Abcd1234'
      }
    )
  end

  def find_by_common_name(common_name)
    filter_condition = Net::LDAP::Filter.eq(COMMON_NAME, common_name)
    treebase = 'dc=c42,dc=in'
    @ldap.search(:base => treebase, :filter => filter_condition) do |ldap_entry|
      common_name = ldap_entry.cn.first
      return User.new(name: common_name, email: common_name + '@c42.in')
    end
  end
end
