class Api::V1::FavoritesController < ApplicationController
  def show
    favorite = UserSong.find(params[:id])
    render json: SongSerializer.new(Song.find(favorite.song_id))
  end
end
