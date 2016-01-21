class StaticPagesController < ApplicationController
  def home
    if (LdapConfiguration.count > 0)
      render :home
      return
    end
    redirect_to new_ldap_configuration_path
  end
end
