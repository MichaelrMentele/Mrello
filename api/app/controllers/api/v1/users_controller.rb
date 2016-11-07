class Api::V1::UsersController < ApplicationController
  def create
    user = User.create(user_params)
    render json: 
      { status: 'SUCCESS', message: "New user created.", user: user }, 
      status: :ok
  end

  def show
    render json: User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:fullname)
  end
end