class Api::V1::ListsController < ApplicationController
  before_action :authenticate_request
  
  def create
    @list = List.new(list_params.merge!(user_id: current_user.id))
    if @list.save
      render json: {
        message: "List created.", 
        list: @list 
      }, status: :created
    else
      render json: { 
        message: "List not created. Invalid inputs." 
      }, status: :not_acceptable
    end
  end

  def update
    @list = List.find(params[:id])
    if @list.update_attributes(list_params)
      render json: {
        message: "List created.", 
        list: @list 
      }, status: :ok
    else
      render json: {
        message: "List not created. Invalid inputs." 
      }, status: :not_acceptable

    end
  end

  def destroy
    if current_user.lists.exists?(params[:id])
      List.destroy(params[:id])
      render json: {
        message: "List deleted.",
      }, status: :accepted
    else
      render json: {
        message: "List not found."
      }, status: :not_acceptable
    end
  end

  def index
    @lists = current_user.lists
  end

  def show
    @list = current_user.lists.find(params[:id])
  end

  private

  def list_params
    params.permit(:title)
  end 
end