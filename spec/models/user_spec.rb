require "rails_helper"

RSpec.describe User, :type => :model do
  it 'should not receive a confirmation email when created' do
    expect {
      create(:valid_user)
    }.to_not change { ActionMailer::Base.deliveries.count }
  end

  it 'should not be registered by default' do
    user = create(:valid_user)
    expect(user).to_not be_registered
  end

  it 'can be registered' do
    user = create(:valid_user)
    user.register!
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

  it 'has a name' do
    user = create(:valid_user)
    expect(user.name).to eq('Test')
  end

  it 'should have a name' do
    user = build(:valid_user)
    user.name = nil
    user.save
    expect(user).to_not be_valid
  end
end
