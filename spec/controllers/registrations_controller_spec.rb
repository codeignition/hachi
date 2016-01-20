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
    context 'a user who is not present in ldap and database' do
      it 'no email is queued' do
        expect {
          post :create, user: {email: 'user_not_present@c42.in'}
        }.to_not change { ActionMailer::Base.deliveries.count }
      end

      it 'he is not added to database' do
        expect {
          post :create, user: {email: 'user_not_present@c42.in'}
        }.to_not change { User.count }
      end
    end

    context 'a user who is present in ldap but not in database' do
      it 'he is added to database' do
        expect {
          post :create, user: {email: 'adam@c42.in'}
        }.to change { User.count }.by(1)
      end

      it 'an email is queued' do
        expect {
          post :create, user: {email: 'adam@c42.in'}
        }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end

    context 'a user who is present in ldap and in database' do
      it 'no email is queued' do
        valid_user = create(:valid_user, name: 'Adam', email: 'adam@c42.in')
        expect {
          post :create, user: {email: valid_user.email}
        }.to_not change { ActionMailer::Base.deliveries.count }
      end

      it 'no new user is created' do
        valid_user = create(:valid_user, name: 'Adam', email: 'adam@c42.in')
        expect {
          post :create, user: {email: valid_user.email}
        }.to_not change { User.count }
      end

      it 'should not be saved again' do
        unregistered_valid_user = create(:valid_user, name: 'Adam', email: 'adam@c42.in')
        expect(unregistered_valid_user).to_not receive(:save!)
        post :create, user: {email: unregistered_valid_user.email}
      end
    end
  end
end
