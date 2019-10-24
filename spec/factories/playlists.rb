FactoryBot.define do
  factory :playlist do
    user
    name { Faker::Lorem.sentence }
  end
end
