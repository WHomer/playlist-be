class SongSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name,
             :album,
             :artist,
             :genre,
             :rating
end
