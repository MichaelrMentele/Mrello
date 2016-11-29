class Api::V1::SessionsController < ApplicationController

  def create
    @auth = AuthenticateUser.call(session_params[:email], session_params[:password])
    if @auth.success?
      @user =  User.find_by(email: session_params[:email])
      @token = @auth.result
      @message = "User login token created."
      render :create, status: :created
    else
      @message = "Invalid credentials."
      render 'api/v1/shared/error', status: :not_acceptable
    end
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end