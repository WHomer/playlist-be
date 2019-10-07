FactoryBot.define do
  factory :song do
    source_track_id { |n| n }
    name { Faker::Music::Phish.song }
    album { Faker::Music.album }
    artist { Faker::Music.band }
    genre { Faker::Music.genre }
    rating { rand(101) }
  end
end
