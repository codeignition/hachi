require "rails_helper"

RSpec.describe LdapConfigurationsController, :type => :controller do
  it 'knows how to render new configuration template' do
    get :new
    expect(response).to render_template :new
  end

  describe 'creation of ldap configuration' do
    it 'with valid params redirects to root path' do
      post :create, ldap_configuration: valid_ldap_configuration
      expect(response).to redirect_to(root_path)
    end
  end

  private
  def valid_ldap_configuration
    {
      'host' => '192.168.33.101',
      'port' => '389',
      'dn' => 'example',
      'search_base' => 'example_search_base',
      'email' => 'test@example.com',
      'ssh_public_key' => '123456789ABCDEFGHI',
      'hachi_admin_usernames' => 'test_one,test_two,test_3',
      'ldap_admin_username' => 'test_admin',
      'ldap_admin_password' => '!Abcd1234'
    }
  end
end