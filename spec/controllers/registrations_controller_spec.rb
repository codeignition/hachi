require "rails_helper"

RSpec.describe RegistrationsController, :type => :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  it 'renders the new registration page' do
    get :new
    expect(response).to render_template :new
  end

  context 'when tried to register a user' do
    it 'a confirmation email is queued if he is already present' do
      valid_user = User.create(email: 'test_1@example.com')
      expect {
        post :create, user: {email: valid_user.email}
      }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'is registered if he is present' do
      valid_user = create(:valid_user)
      post :create, user: attributes_for(:valid_user)
      valid_user.reload
      expect(valid_user).to be_registered
    end

    it 'no confirmation email is queued if he is not present' do
      expect {
        post :create, user: {email: 'unsaved_user-email@example.com'}
      }.to_not change { ActionMailer::Base.deliveries.count }
    end

    it 'is not registered if he is not present' do
      user = build(:valid_user)
      post :create, user: attributes_for(:valid_user)
      expect(user).to_not be_registered
    end
  end
end
