require "rails_helper"

RSpec.describe User, :type => :model do
  context 'when compared for equality with' do
    let(:user) { User.new(name: 'Test', email: 'test@example.com') }

    it 'nil is not equal' do
      expect(user == nil).to eq(false)
    end

    it 'anything other than User is not equal' do
      expect(user == Object.new).to eq(false)
    end

    it 'itself is equal' do
      expect(user == user).to eq(true)
    end

    it 'other User with different name and email is not equal' do
      other_user = User.new(name: 'Another Test', email: 'another_test@example.com')
      expect(user == other_user).to eq(false)
    end

    it 'other User with same name and email is equal' do
      other_user = User.new(name: 'Test', email: 'test@example.com')
      expect(user == other_user).to eq(true)
    end
  end

  it 'with the same name and email are same in business context' do
    user = User.new(name: 'Test', email: 'test@example.com')
    other_user = User.new(name: 'Test', email: 'test@example.com')
    expect(user.hash).to eq(other_user.hash)
  end

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

  it 'is not valid without a name' do
    user = build(:valid_user)
    user.name = nil
    user.save
    expect(user).to_not be_valid
  end

  context 'has a' do
    let(:user) { create(:valid_user) }
    it 'name' do
      expect(user).to respond_to(:name)
    end

    it 'uid' do
      expect(user).to respond_to(:uid)
    end

    it 'uid same as name' do
      expect(user.uid).to eq(user.name)
    end

    it 'uid number' do
      expect(user).to respond_to(:uid_number)
    end

    it 'uid number equal to 10000 (lower bound) plus value of id' do
      expect(user.uid_number).to eq(user.id + 10000)
    end

    it 'dn' do
      expect(user).to respond_to(:dn)
    end

    it 'ssh_public_key' do
      expect(user).to respond_to(:ssh_public_key)
    end
  end
end
