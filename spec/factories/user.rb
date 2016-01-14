FactoryGirl.define do
  factory :valid_user, class: User do
    name 'Test'
    email "test@example.com"
    registered false
  end
end