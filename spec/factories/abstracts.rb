FactoryBot.define do
  factory :abstract do
    file_id { SecureRandom.alphanumeric(10) }
    image_link { "An image link" }
    download_link { "A download link" }
    association :admission
  end
end
