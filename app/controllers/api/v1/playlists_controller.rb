class Api::V1::PlaylistsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_playlist, only: :show
  
  def index
    playlists = current_user.playlists

    render json: PlaylistSerializer.new(playlists)
  end

  def show
    render json: PlaylistSerializer.new(@playlist)
  end

  private

  def find_playlist
    @playlist = current_user.playlists.find(params[:id])
  end
end