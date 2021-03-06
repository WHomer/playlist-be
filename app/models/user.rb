class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JWTBlacklist

  alias_attribute :favorites, :user_songs

  has_many :user_songs
  has_many :songs, through: :user_songs
  has_many :playlists
end
