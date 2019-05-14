module Api
  class MoviesController < ActionController::API
    before_action :find_movie, only: [:show]

    def index
      @movies = ::Movie.all
      render json: @movies, each_serializer: Api::MovieSerializer
    end

    def show
      render json: @movie, serializer: Api::MovieSerializer
    end

    private

    def find_movie
      @movie = ::Movie.find(params[:id])
    end

  end
end