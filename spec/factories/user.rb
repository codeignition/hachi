FactoryGirl.define do
  factory :valid_user, class: User do
    email "test@example.com"
    registered false
  end
end