class LdapConfigurationsController < ActionController::Base
  def new
    @ldap_configuration = LdapConfiguration.new
  end
end