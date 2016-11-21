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
    # TODO refactor to only look in current users todos
    List.destroy(params[:id])
    render json: {
      message: "SUCCESS: List deleted.",
    }, status: :accepted

  end

  def index
    @lists = current_user.lists
  end

  def show
    @list = List.find(params[:id])
  end

  private

  def list_params
    params.require(:list).permit(:title)
  end 
end