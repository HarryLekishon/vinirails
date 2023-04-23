class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :authorized!, only: [:create, :index]
    # skip_before_action :authenticate_user, only: [:index, :create, :show, :destroy]
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  
    def index
        users = User.all
        render json: users
      end
    
        def create
            user = User.create!(user_params)
            if user.valid?
              session[:user_id] = user.id 
              render json: user, status: :created
            # rescue ActiveRecord::RecordInvalid => e
            #   render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
            else
              render json: user.errors.full_messages, status: :unprocessable_entity
            end
          end
    
          def show
            if current_user
              render json: current_user, status: :ok
            else
              render json: "No current session stored", status: :unauthorized
            end
          end

          def destroy
            user = find_user;
            user.destroy;
            head :no_content
        end

        def find_user
            User.find_by(params[:id])
        end
    
          def authenticate_user
            return render json: { error: "Not authorized" }, status: :unauthorized unless current_user
          end
    
    
          def user_params
            params.permit(:name, :username, :email, :password, :password_confirmation, :admin)
        end
        def render_not_found_response
          render json: { error: "User not found" }, status: :not_found
      end
          
end
