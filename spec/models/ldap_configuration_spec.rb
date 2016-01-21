require 'rails_helper'

RSpec.describe LdapConfiguration, :type => :model do
  context 'validations' do
    let(:ldap_configuration) { build(:ldap_configuration) }

    it 'host should be present' do
      ldap_configuration.host = ''
      expect(ldap_configuration).to_not be_valid
    end

    it 'port should be present' do
      ldap_configuration.port = ''
      expect(ldap_configuration).to_not be_valid
    end

    it 'dn should be present' do
      ldap_configuration.dn = ''
      expect(ldap_configuration).to_not be_valid
    end

    it 'search base should be present' do
      ldap_configuration.search_base = ''
      expect(ldap_configuration).to_not be_valid
    end

    it 'email should be present' do
      ldap_configuration.email = ''
      expect(ldap_configuration).to_not be_valid
    end

    it 'ssh public key should be present' do
      ldap_configuration.ssh_public_key = ''
      expect(ldap_configuration).to_not be_valid
    end

    it 'hachi admin usernames should be present' do
      ldap_configuration.hachi_admin_usernames = ''
      expect(ldap_configuration).to_not be_valid
    end

    it 'ldap admin username should be present' do
      ldap_configuration.ldap_admin_username = ''
      expect(ldap_configuration).to_not be_valid
    end

    it 'ldap admin password should be present' do
      ldap_configuration.ldap_admin_password = ''
      expect(ldap_configuration).to_not be_valid
    end
  end
end
