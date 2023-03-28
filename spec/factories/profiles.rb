FactoryBot.define do
  factory :profile do
    birth_date { 18.years.ago }
    address { "Street, City, Province" }
    nationality { "Filipino" }
    civil_status { "Single" }
    contact_number { "12345678910" }
    height { 1.60 }
    weight { 50.0 }
    sex { "Male" }
    blood_type { "A+" }
    association :user
  end
end