FactoryBot.define do
  factory :movement do
    description { "MyString" }
    category { nil }
    movement_date { "2021-04-07" }
    user { nil }
    amoutn { "9.99" }
  end
end
