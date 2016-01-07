require "rails_helper"

RSpec.describe RegistrationsController, :type => :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  it 'renders the new registration page' do
    get :new
    expect(response).to render_template :new
  end

  it 'queues a confirmation email' do
    valid_user = User.create(email: 'test_1@example.com')
    expect {
      post :create, user: { email: valid_user.email }
    }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
