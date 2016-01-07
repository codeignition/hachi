require "rails_helper"

RSpec.describe RegistrationsController, :type => :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  it 'renders the new registration page' do
    get :new
    expect(response).to render_template :new
  end

  describe 'when tried to register' do
    context 'a user who is present in the database' do
      it 'a confirmation email is queued' do
        valid_user = User.create(email: 'test_1@example.com')
        expect {
          post :create, user: {email: valid_user.email}
        }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it 'is registered' do
        valid_user = create(:valid_user)
        post :create, user: attributes_for(:valid_user)
        valid_user.reload
        expect(valid_user).to be_registered
      end
    end

    describe 'a user who is not present in the database' do
      it 'no confirmation email is queued' do
        expect {
          post :create, user: {email: 'unsaved_user-email@example.com'}
        }.to_not change { ActionMailer::Base.deliveries.count }
      end

      it 'is not registered' do
        user = build(:valid_user)
        post :create, user: attributes_for(:valid_user)
        expect(user).to_not be_registered
      end
    end
  end
end
