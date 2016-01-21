class StaticPagesController < ApplicationController
  def home
    redirect_to new_ldap_configuration_path
  end
end
