require 'net/ldap'
require 'rails_helper'

RSpec.describe LdapUsers, :type => :model do
  xit 'should find a user by common name if the user is present in LDAP' do
    ldap_users = LdapUsers.new
    user = User.new(name: 'adam', email: 'adam@c42.in')
    ldap = double(Net::LDAP)
    allow(ldap).to receive(:search).and_return(user)
    expect(ldap_users.find_by_common_name('adam')).to eq(user)
  end

  xit 'should not be able to find a user if the user is not present in LDAP' do
    ldap_users = LdapUsers.new
    expect(ldap_users.find_by_common_name('jenson')).to eq(nil)
  end

  xit 'should not be able to find a user if connection cannot be established' do
    ldap_users = LdapUsers.new
    ldap_users.instance_variable_set(:@ldap, unreachable_ldap_connection)
    expect(ldap_users.find_by_common_name('adam')).to eq(nil)
  end

  private
  def unreachable_ldap_connection
    Net::LDAP.new(
        :host => '000.000.0.0',
        :port => '389',
        :auth => {
            :method => :simple,
            :username => APP_CONFIG['ldap_admin_username'],
            :password => APP_CONFIG['ldap_admin_password']
        }
    )
  end
end
