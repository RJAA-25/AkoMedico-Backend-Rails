FactoryBot.define do
  factory :prescription do
    file_id { SecureRandom.alphanumeric(10) }
    image_link { "An image link" }
    download_link { "A download link" }

    trait :for_consult do
      association :prescription_issue, factory: :consultation
    end

    trait :for_admit do
      association :prescription_issue, factory: :admission
    end
  end
end
