FactoryBot.define do
  factory :user do
    email { "MyString" }
    first_name { "MyString" }
    last_name { "MyString" }
    auth_token { "MyString" }
    family { nil }
  end
end
