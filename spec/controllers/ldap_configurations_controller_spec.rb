require "rails_helper"

RSpec.describe LdapConfigurationsController, :type => :controller do
  it 'knows how to render new configuration template' do
    get :new
    expect(response).to render_template :new
  end
end