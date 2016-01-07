require "rails_helper"

RSpec.describe User, :type => :model do
  it 'should not receive a confirmation email when created' do
    expect {
      User.create(email: 'test_1@example.com')
    }.to_not change { ActionMailer::Base.deliveries.count }
  end
end