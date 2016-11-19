class Api::V1::UsersController < ApplicationController
  before_action :authenticate_request, except: [:create]
  
  def create
    @user = User.create(user_params)
    if @user.save
      render json: { 
        message: "New user created.", 
        user: @user
      }, status: :created
    else
      render json: {
        message: "User not created. Invalid inputs."
      }, status: :not_acceptable
    end
  end

  private

  def user_params
    params.permit(:fullname, :email, :password)
  end
end