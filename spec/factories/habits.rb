FactoryBot.define do
  factory :habit do
    name { "fix tiny arms" }
    days_of_week { [1, 3, 5] }
    time_of_day { "10:00" }
    association :user
  end
end
