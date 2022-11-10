FactoryBot.define do
  factory :result do
    file_id { SecureRandom.alphanumeric(10) }
    image_link { "An image link" }
    download_link { "A download link" }

    trait :for_consult do
      association :result_issue, factory: :consultation
    end

    trait :for_admit do
      association :result_issue, factory: :admission
    end
  end
end
