FactoryBot.define do
  factory :user do
    email { "example@example.com" }
    name { Faker::Lorem.word }
    confirmed_at { Faker::Date.between(40.years.ago, Time.zone.today) }
    password { "password" }
    password_confirmation { "password" }
  end
end
