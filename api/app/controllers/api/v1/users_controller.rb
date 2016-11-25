class Api::V1::UsersController < ApplicationController
  before_action :authenticate_request, except: [:create]
  
  def create
    @user = User.new(user_params)
    if @user.save
      @message = "New user created."
      render :create, status: :created
    else
      @message = "Invalid credentials."
      render 'api/v1/shared/error', status: :not_acceptable
    end
  end

  def update
    if current_user.update_attributes(user_params)
      @user = current_user
      @message = "User updated."
      render :update, status: :accepted
    else
      @message = "Error: invalid inputs."
      render 'api/v1/shared/error', status: :not_acceptable
    end
  end

  def show
    @user = current_user
    @message = "Return current user."
    render :show, status: :ok
  end

  private

  def user_params
    params.permit(:fullname, :email, :password, :admin, :organization_id)
  end
end