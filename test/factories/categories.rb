# == Schema Information
#
# Table name: categories
#
#  id            :bigint           not null, primary key
#  name          :string
#  family_id     :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  category_type :integer
#
FactoryBot.define do
  factory :category do
    name { Faker::Internet.user_name }
    category_type { 2 }
    family
  end
end
