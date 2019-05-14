module Api
  module V2
    class MoviesController < ActionController::API
      before_action :find_movie, only: [:show]

      def index
        @movies = ::Movie.includes(:genre).all
        render json: @movies, each_serializer: Api::V2::MovieSerializer
      end

      def show
        render json: @movie, serializer: Api::V2::MovieSerializer
      end

      private

      def find_movie
        @movie = ::Movie.find(params[:id])
      end
    end
  end
end