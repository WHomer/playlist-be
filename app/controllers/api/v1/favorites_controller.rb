class Api::V1::FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_favorite, only: [:show, :destroy]

  def index
    songs = current_user.songs
    render json: SongSerializer.new(songs)
  end

  def create
    song = Song.find_or_create_by(song_params)
    current_user.favorites.create(song: song)

    render json: SongSerializer.new(song), status: 201
  end

  def show
    render json: SongSerializer.new(Song.find(@favorite.song_id))
  end

  def destroy
    @favorite.destroy
  end

  private

  def song_params
    params.permit(:source_track_id, :name, :artist, :album, :genre, :rating)
  end

  def find_favorite
    @favorite = current_user.favorites.find(params[:id])
  end
end
