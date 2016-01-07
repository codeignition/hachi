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
end
