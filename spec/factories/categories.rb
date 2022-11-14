FactoryBot.define do
  factory :category do
    name { "Consultations" }
    folder_id { SecureRandom.alphanumeric(10) }
    association :user
  end
end
