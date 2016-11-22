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
    if current_user.update_attributes(user_params)
      render json: {
        message: "User updated.",
        user: current_user
      }, status: :accepted
    else
      render json: {
        message: "Error updating."
      }, status: :not_acceptable
    end
  end

  private

  def user_params
    params.permit(:fullname, :email, :password, :admin, :organization_id)
  end
end