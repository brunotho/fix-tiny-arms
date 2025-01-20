FactoryBot.define do
  factory :habit do
    name { "fix tiny arms" }
    days_of_week { [1, 3, 5] }
    association :user
  end
end
