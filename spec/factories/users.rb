FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name { "Doe" }
    email { "john_doe@email.com" }
    password { "johndoe_password" }
  end

  factory :valid_login_params, class: "User" do
    email { "john_doe@email.com" }
    password { "johndoe_password"}
  end

  factory :invalid_login_params, class: "User" do
    email { "no_email_record" }
    password { "no_password_record" }
  end

  factory :valid_email_params, class: "User" do
    email { "valid_email@email.com" }
  end

  factory :invalid_email_params, class: "User" do
    email { "invalid_email" }
  end

  factory :valid_password_params, class: "User" do
    password { "valid_password" }
    password_confirmation { "valid_password" }
  end

  factory :invalid_password_params, class: "User" do
    password { "12345" }
    password_confirmation { "another_password" }
  end
end