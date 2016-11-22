class Api::V1::SessionsController < ApplicationController

  def create
    auth = AuthenticateUser.call(session_params[:email], session_params[:password])
    if auth.success?
      render json: {
        message: "User logged in.", 
        session_token: auth.result,
        # TODO: refactor -> only return safe information
        user: User.find_by(email: session_params[:email])
      }, status: :created
    else
      render json: {
        message: "Invalid inputs."
      }, status: :not_acceptable
    end
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end