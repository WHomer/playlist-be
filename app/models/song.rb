class Song < ApplicationRecord
  has_many :user_songs
  has_many :users, through: :user_songs
  has_many :playlist_songs
  has_many :playlists, through: :playlist_songs
end
