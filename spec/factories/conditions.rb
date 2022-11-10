FactoryBot.define do
  factory :condition do
    diagnosis { "Type II Diabetes" }
    start_date { 2.years.ago }
    end_date { nil }
    association :user
  end
end
