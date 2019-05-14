class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  def index
    @movies = Movie.all.decorate
  end

  def show
    @movie = Movie.find(params[:id])
    @comments = @movie.comments.includes(:user)
  end

  def send_info
    @movie = Movie.find(params[:id])
    MovieInfoMailerJob.perform_later(current_user, @movie)
    redirect_back(fallback_location: root_path, notice: "Email sent with movie info")
  end

  def export
    MovieExporterJob.perform_later(current_user)
    redirect_to root_path, notice: "Movies exported"
  end
end
