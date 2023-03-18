FactoryBot.define do
  factory :result do
    image_url { "An image url" }

    trait :for_consult do
      association :result_issue, factory: :consultation
    end

    trait :for_admit do
      association :result_issue, factory: :admission
    end
  end
end
