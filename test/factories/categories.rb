FactoryBot.define do
  factory :category do
    name { Faker::Internet.user_name }
    type { 1 }
    family { nil }
  end
end
