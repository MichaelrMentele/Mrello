class Api::V1::ListsController < ApplicationController
  before_action :authenticate_request
  before_action :check_access, only: [:update, :destroy]
  
  def create
    @list = List.new(list_params)
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
    @list = List.find(params[:id]).destroy!
    @message = "List deleted."
    render :destroy, status: :accepted
  end

  def index
    if current_user.has_access_to("Boards", params[:board_id])
      @lists = Board.find(params[:board_id]).lists
      @message = "Returning current boards lists."
      render :index, status: :ok
    else
      @message = "You do not have access to the lists on that board."
      render 'api/v1/shared/error', status: :unauthorized
    end
  end

  def show
    @list = current_user.all_accessible_lists.find(params[:id])
    @message = "Returning current users lists."
    render :show, status: :ok
  end

  private

  def list_params
    params.permit(:title, :board_id)
  end 
end