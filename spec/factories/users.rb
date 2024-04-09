FactoryBot.define do
  factory :user do
    Faker::Config.locale = :ja
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.email }
    password              { "1a#{Faker::Internet.password(min_length: 4)}" }
    password_confirmation { password }
    first_name            { Faker::Name.first_name }
    last_name             { Faker::Name.last_name }
    read_first_name       { Faker::Creature::Dog.name } # カタカナのダミーデータ
    read_last_name        { Faker::Creature::Dog.name }
    birth                 { Faker::Date.between(from: '1930-01-01', to: '2019-12-31') }
  end
end
