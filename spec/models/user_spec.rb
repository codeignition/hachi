require "rails_helper"

RSpec.describe User, :type => :model do
  it 'should not receive a confirmation email when created' do
    expect {
      User.create(email: 'test_1@example.com')
    }.to_not change { ActionMailer::Base.deliveries.count }
  end

  it 'should not be registered by default' do
    user = User.create(email: 'test_1@example.com')
    expect(user).to_not be_registered
  end

  it 'can be registered' do
    user = User.create(email: 'test_1@example.com')
    user.update_attributes(registered: true)
    expect(user).to be_registered
  end

  it 'should not be active by default' do
    user = create(:valid_user)
    expect(user).to_not be_active
  end

  it 'remains registered when registered again' do
    user = create(:valid_user, registered: true)
    user.register!
    expect(user).to be_registered
  end
end
