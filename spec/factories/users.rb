FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "bob#{n}@gmail.com" }
    password { "password" }
  end
end
