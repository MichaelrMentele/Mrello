class Api::V1::SessionsController < ApplicationController
  def create
    session[:user_id] = params[:id]
    render json: 
      { status: 201, message: "User logged in.", user_id: params[:id] }, status: 201
  end

  def destroy
    session[:user_id] = nil
  end
end