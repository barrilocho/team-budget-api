# == Schema Information
#
# Table name: families
#
#  id         :bigint           not null, primary key
#  members    :integer
#  balance    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  code       :string
#  alias_name :string
#
FactoryBot.define do
  factory :family do
    code { Faker::Code.ean8 }
    alias_name { Faker::Internet.user_name}
    members { 1 }
    balance { 1 }
  end
end
