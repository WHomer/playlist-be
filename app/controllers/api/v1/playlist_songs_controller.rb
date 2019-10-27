class Api::V1::PlaylistSongsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_song, only: :create
  before_action :find_playlist, only: [:index, :create]

  def index
    render json: PlaylistSerializer.new(@playlist)
  end

  def create
    @playlist.songs << @song

    render json: { message: "Successfully added #{@song.name} to #{@playlist.name}." }, status: 201
  end

  private

  def find_song
    @song = Song.find(params[:song_id])
  end

  def find_playlist
    @playlist = current_user.playlists.find(params[:id])
  end
end