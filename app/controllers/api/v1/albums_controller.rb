module Api
  module V1
    class AlbumsController < ApplicationController
      def index
        if params[:artist_id].present?
          @albums = Artist.find(params[:artist_id]).albums.includes(:songs).available(:name)
        else
          @albums = Album.includes(:songs).available(:name).all
        end

        render json: @albums.map { |album| format_album_json(album) }
      end

      def show
        @album = Album.find(params[:id])

        render json: format_album_json(@album)
      end

      private
        def format_album_json(album)
          {
            id: album.id,
            name: album.name,
            length_seconds: album.songs.reduce(0) { |length, song| length + song.length_seconds },
            song_count: album.songs.count,
            created_at: album.created_at,
            updated_at: album.updated_at,
          }
        end
    end
  end
end
