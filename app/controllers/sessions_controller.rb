class SessionsController < ApplicationController
    skip_before_action :verify_authenticity_token
    
    skip_before_action :authenticate_user, only: [:create, :show]
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def create
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
          session[:user_id] = user.id
          render json: user, status: :ok
        else
          render json: "Invalid Credentials", status: :unauthorized
          
        end
      end

      def destroy
        session.delete :user_id
      end
      def destroy
        user = User.find(session[:user_id])
        session.delete :user_id
        head :no_content
        rescue ActiveRecord::RecordInvalid => e
          render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
        
            # render json: {errors: ["Not authorized"]}, status: :unauthorized
    
      end
end
