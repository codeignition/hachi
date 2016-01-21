require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  it 'redirects to ldap configuration if no configuration is present' do
    get :home
    expect(response).to redirect_to(new_ldap_configuration_path)
  end
end