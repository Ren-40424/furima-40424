FactoryBot.define do
  factory :order_destination do
    postal_code   { Faker::Address.postcode }
    prefecture_id { Faker::Number.within(range: 2..48) }
    city          { Faker::Address.city }
    address       { Faker::Number.number(digits: 4) }
    building_name { Faker::Lorem.characters(number: 5) }
    phone_number  { Faker::Number.number(digits: rand(10..11)) }
    token         { "tok_#{Faker::Alphanumeric.alpha(number: 11)}#{Faker::Number.number(digits: 17)}" }
  end
end
