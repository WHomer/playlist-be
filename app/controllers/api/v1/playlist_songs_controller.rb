class Api::V1::PlaylistSongsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_playlist, only: [:show, :create, :destroy]
  before_action :find_song, only: [:create, :destroy]

  def show
    render json: PlaylistSerializer.new(@playlist)
  end

  def create
    @playlist.songs.push(@song)

    render json: { message: "Successfully added #{@song.name} to #{@playlist.name}." }, status: 201
  end

  def destroy
    @playlist.songs.delete(@song)

    render json: { message: "Successfully removed #{@song.name} from #{@playlist.name}." }, status: 200
  end

  private

  def find_playlist
    @playlist = current_user.playlists.find(params[:id])
  end

  def find_song
    @song = Song.find(params[:song_id])
  end
end