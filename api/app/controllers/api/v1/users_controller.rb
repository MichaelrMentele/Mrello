class Api::V1::UsersController < ApplicationController
  before_action :authenticate_request, except: [:create]
  
  def create
    @user = User.new(user_params)
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

  def update
    binding.pry
  end

  private

  def user_params
    params.permit(:fullname, :email, :password, :admin)
  end
end