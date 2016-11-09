class Api::V1::ListsController < ApplicationController
  before_action :require_user

  def create
    @list = List.new(list_params)
    if @list.save
      render json: 
        { status: "SUCCESS", message: "List created.", list: @list },
        status: :ok
    else
      render json:
        { status: "FAILURE", message: "List not created. Invalid inputs." },
        status: 406
    end
  end

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  private

  def list_params
    params.require(:list).permit(:title, :user_id)
  end 
end