FactoryBot.define do
  factory :emergency_contact do
    full_name { "Jane Doe" }
    relationship { "Sister" }
    contact_number { "12345678910" }
    association :user
  end
end