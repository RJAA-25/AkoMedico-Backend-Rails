FactoryBot.define do
  factory :profile do
    birthdate { 18.years.ago }
    address { "Street, City, Province" }
    nationality { "Filipino" }
    civil_status { "single" }
    contact_number { "12345678910" }
    height { 1.60 }
    weight { 50.0 }
    sex { "male" }
    blood_type { "A+" }
    association :user
  end
end