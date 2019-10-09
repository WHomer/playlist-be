class Api::V1::FavoritesController < ApplicationController
  before_action :set_favorite, only: :show

  def create
    song = Song.find_or_create_by(song_params)
    UserSong.create(song: song, user_id: params[:user_id])

    render json: SongSerializer.new(song), status: 201
  end

  def show
    render json: SongSerializer.new(Song.find(@favorite.song_id))
  end

  private

  def song_params
    params.permit(:source_track_id, :name, :artist, :album, :genre, :rating)
  end

  def set_favorite
    @favorite = UserSong.find(params[:id])
  end
end
