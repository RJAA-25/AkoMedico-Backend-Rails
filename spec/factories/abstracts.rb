FactoryBot.define do
  factory :abstract do
    image_url { "An image url" }
    association :admission
  end
end
