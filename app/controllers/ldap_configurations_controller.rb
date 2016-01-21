class LdapConfigurationsController < ActionController::Base
  def new
    @ldap_configuration = LdapConfiguration.new
  end

  def create
    redirect_to root_path
  end
end