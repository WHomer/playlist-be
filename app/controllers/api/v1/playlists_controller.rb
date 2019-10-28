class Api::V1::PlaylistsController < ApplicationController
  before_action :authenticate_user!

  def index
    playlists = current_user.playlists

    render json: PlaylistSerializer.new(playlists)
  end
end