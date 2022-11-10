FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name { "Doe" }
    email { "john_doe@email.com" }
    password { "johndoe_password" }
  end
end