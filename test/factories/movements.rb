# == Schema Information
#
# Table name: movements
#
#  id            :bigint           not null, primary key
#  description   :string
#  user_id       :bigint           not null
#  category_id   :bigint           not null
#  movement_date :date
#  amount        :decimal(, )
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :movement do
    description { Faker::Lorem.sentence   }
    category
    movement_date { "2021-04-07" }
    user
    amoutn { Faker::Number.decimal(l_digits: 2) }
  end
end
