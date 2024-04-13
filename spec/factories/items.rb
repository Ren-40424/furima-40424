FactoryBot.define do
  factory :item do
    name              { Faker::Lorem.characters(number: 10) }
    explanation       { Faker::Lorem.sentence }
    price             { Faker::Number.within(range: 300..9_999_999) }
    category_id       { Faker::Number.within(range: 2..11) }
    condition_id      { Faker::Number.within(range: 2..7) }
    shipping_payer_id { Faker::Number.within(range: 2..3) }
    prefecture_id     { Faker::Number.within(range: 2..48) }
    shipping_date_id  { Faker::Number.within(range: 2..4) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
