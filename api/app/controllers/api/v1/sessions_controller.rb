class Api::V1::SessionsController < ApplicationController
  def create
    session[:user_id] = params[:id]
  end

  def destroy
    session[:user_id] = nil
  end
end