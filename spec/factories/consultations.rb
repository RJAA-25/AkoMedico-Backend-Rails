FactoryBot.define do
  factory :consultation do
    folder_id { SecureRandom.alphanumeric(10) }
    diagnosis { "Vertigo" }
    health_facility { "Philippine General Hospital" }
    schedule { 5.days.ago }
    notes { nil }
    association :user
  end
end
