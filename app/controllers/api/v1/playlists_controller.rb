class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:show]

  # GET /user/:user_id/playlists
  def index
    @playlists = Playlist.find!(playlist_params[:user_id])

    render json: @playlists
  end

  # GET /playlists/1
  def show
    render json: @playlist
  end

  # POST /user/:user_id/playlists
  def create
    @playlist = Playlist.new(playlist_params)

    if @playlist.save
      render json: @playlist, status: :created, location: @playlist
    else
      render json: @playlist.errors, status: :unprocessable_entity
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_playlist
      @playlist = Playlist.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def playlist_params
      params.require(:playlist).permit(:name, :user_id)
    end
end
