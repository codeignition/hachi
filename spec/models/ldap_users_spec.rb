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
end
