FactoryBot.define do
  factory :song do
    source_track_id { 1 }
    name { "MyString" }
    album { "MyString" }
    artist { "MyString" }
  end
end
