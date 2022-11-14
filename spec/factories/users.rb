FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name { "Doe" }
    email { "john_doe@email.com" }
    password { "johndoe_password" }
  end

  factory :valid_login, class: "User" do
    email { "john_doe@email.com" }
    password { "johndoe_password"}
  end

  factory :invalid_login, class: "User" do
    email { "no_email_record" }
    password { "no_password_record" }
  end
end