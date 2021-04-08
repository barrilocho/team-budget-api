FactoryBot.define do
  factory :movement do
    description { Faker::Lorem.sentence   }
    category
    movement_date { "2021-04-07" }
    user
    amoutn { Faker::Number.decimal(l_digits: 2) }
  end
end
