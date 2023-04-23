class MoviesController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :authorized!, only: [:create, :index]
    def index
        @movies = Movie.all
        render json: @movies
      end
    
      def create
        # movies_params = params.require(:movies)
        # movies_params.each do |movie_params|
        #   movie = Movie.new(movie_params.permit(:title, :overview, :release_date))
        #   if movie.save
        #     # Successfully saved the movie to the database
        #     render json: { message: 'Movies were successfully saved to the database' }, status: :created
        #   else
        #     # Error saving the movie to the database
        #     render json: { error: 'Failed to save movies to the database' }, status: :unprocessable_entity
        #   end
        # end
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
