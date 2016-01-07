require "rails_helper"

RSpec.describe RegistrationsController, :type => :controller do
  it 'renders the new registration page' do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    get :new
    expect(response).to render_template :new
  end
end
