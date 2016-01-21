class LdapConfigurationsController < ActionController::Base
  def new
    @ldap_configuration = LdapConfiguration.new
  end

  def create
    ldap_configuration = LdapConfiguration.create(ldap_configuration_params)
    if(ldap_configuration.valid?)
      redirect_to root_path
      return
    end
    render :new
  end

  private
  def ldap_configuration_params
    params.require(:ldap_configuration).
        permit('host', 'port', 'dn', 'search_base', 'email',
               'ssh_public_key', 'hachi_admin_usernames',
               'ldap_admin_username', 'ldap_admin_password'
        )
  end
end