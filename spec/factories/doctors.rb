FactoryBot.define do
  factory :doctor do
    first_name { "Jack" }
    last_name { "Daniels" }
    specialty { "Internal Medicine" }
    association :user
  end
end
