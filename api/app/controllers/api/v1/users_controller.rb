class Api::V1::UsersController < ApplicationController
  before_action :require_login, only: [:show]
  
  def create
    @user = User.create(user_params)
    if @user.save
      render json: 
        { status: 'SUCCESS', message: "New user created.", user: @user }, 
        status: :ok
    else
      render json: 
        { status: "FAILURE", message: "User not created. Invalid inputs." },
        status: 406
    end
  end

  def show
    render json: User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:fullname, :email, :password)
  end
end