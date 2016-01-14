FactoryGirl.define do
  factory :valid_user, class: User do
    sequence(:name) { |number|  "Test_#{number}" }
    sequence(:email) { |number| "test_#{number}@example.com" }
    registered false
  end
end