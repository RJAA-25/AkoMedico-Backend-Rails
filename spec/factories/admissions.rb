FactoryBot.define do
  factory :admission do
    folder_id { SecureRandom.alphanumeric(10) }
    diagnosis { "Appendicitis" }
    health_facility { "Philippine General Hospital" }
    start_date { 7.days.ago }
    end_date { 4.days.ago }
    notes { nil }
    association :user
  end
end
