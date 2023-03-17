FactoryBot.define do
  factory :prescription do
    image_url { "An image url" }

    trait :for_consult do
      association :prescription_issue, factory: :consultation
    end

    trait :for_admit do
      association :prescription_issue, factory: :admission
    end
  end
end
