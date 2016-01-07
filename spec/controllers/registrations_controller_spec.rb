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
      let(:valid_user) { create(:valid_user) }
      it 'a confirmation email is queued' do
        expect {
          post :create, user: { email: valid_user.email }
        }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it 'is registered' do
        post :create, user: { email: valid_user.email }
        valid_user.reload
        expect(valid_user).to be_registered
      end

      it 'and is registered already, a confirmation email is not queued' do
        registered_valid_user = create(:valid_user, registered: true)
        expect {
          post :create, user: { email: registered_valid_user.email }
        }.to_not change { ActionMailer::Base.deliveries.count }
      end

      it 'it has the correct flash notice promising a confirmation email sent' do
        valid_user = create(:valid_user)
        post :create, user: { email: valid_user.email }
        expect(flash[:notice]).to eq('A confirmation email has been sent to you')
      end

      it 'and is registered already, it has the correct flash notice mentioning that he is already registered' do
        registered_valid_user = create(:valid_user, registered: true)
        post :create, user: { email: registered_valid_user.email }
        expect(flash[:notice]).to eq('You have already registered')
      end
    end

    context 'a user who is not present in the database' do
      it 'no confirmation email is queued' do
        expect {
          post :create, user: { email: 'unsaved_user-email@example.com' }
        }.to_not change { ActionMailer::Base.deliveries.count }
      end

      it 'is not registered' do
        user = build(:valid_user)
        post :create, user: { email: user.email }
        expect(user).to_not be_registered
      end

      it 'it has the correct flash notice mentioning that the user is not a part of the organization' do
        post :create, user: { email: 'test_999test@example.com' }
        expect(flash[:notice]).to eq('You are not a part of this organization')
      end
    end
  end
end
