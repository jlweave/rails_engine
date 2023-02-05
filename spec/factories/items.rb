FactoryBot.define do
  factory :item do
    merchant
    name { Faker::Food.dish }
    description { Faker::Food.ingredient }
    unit_price { Faker::Number.decimal(l_digits: 2) }
  end
end