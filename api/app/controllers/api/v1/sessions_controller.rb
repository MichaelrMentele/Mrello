class Api::V1::SessionsController < ApplicationController
  def create
    @user = User.find_by(email: session_params[:email])
    if @user and @user.authenticate(session_params[:password])
      render json: {
        message: "SUCCESS: User logged in.", 
        session_token: "SECRET JWT TOKEN I HAVEN\'t MADE YET"
      }, status: :created
    else
      render json: {
        message: "FAILURE: Invalid inputs."
      }, status: :not_acceptable
    end
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end