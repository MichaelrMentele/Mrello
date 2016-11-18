class Api::V1::SessionsController < ApplicationController
  def create
    binding.pry
    user = User.find_by(email: session_params[:email])
    if user.authenticate(session_params[:password])
      render json: {
        status: :created, 
        message: "User logged in.", 
        session_token: "SECRET JWT TOKEN I HAVEN\'t MADE YET"
      }
    else

    end
  end

  def destroy
    session[:user_id] = nil
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end