class MoviesController < ApplicationController
    skip_before_action :authorized!, only: [:create, :index]
    def index
        @movies = Movie.all
        render json: @movies
      end
    
      def create
        movies_params[:movies].each do |movie|
          Movie.find_or_create_by(tmdb_id: movie["id"]) do |m|
            m.title = movie["title"]
            m.overview = movie["overview"]
            m.release_date = movie["release_date"]
          end
        end
        head :ok
      end
    
      private
    
      def movies_params
        params.permit(movies: [:id, :title, :overview, :release_date])
      end
end
