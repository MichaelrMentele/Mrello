class Api::V1::ListsController < ApplicationController
  before_action :authenticate_request
  
  def create
    @list = List.new(list_params.to_h.merge(user_id: current_user.id))
    if @list.save
      @message = "List created."
      render :create, status: :created
    else
      @message = "List not created. Invalid inputs."
      render 'api/v1/shared/error', status: :not_acceptable
    end
  end

  def update
    @list = List.find(params[:id])
    if @list.update_attributes(list_params)
      @message = "List updated."
      render :update, status: :accepted
    else
      @message = "List not updated. Invalid inputs." 
      render 'api/v1/shared/error', status: :not_acceptable
    end
  end

  def destroy
    if current_user.lists.exists?(params[:id])
      @list = List.find(params[:id])
      @list.destroy!
      @message = "List deleted."
      render :destroy, status: :accepted
    else
      @message = "List not found."
      render 'api/v1/shared/error', status: :not_acceptable
    end
  end

  def index
    @lists = current_user.lists
    render :index, status: :ok
  end

  def show
    @list = current_user.lists.find(params[:id])
    render :show, status: :ok
  end

  private

  def list_params
    params.permit(:title)
  end 
end