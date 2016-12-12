class Api::V1::BoardsController < ApplicationController
  before_action :authenticate_request
  before_action :check_access, only: [:show]

  def create
    @board = Board.new(board_params)
    if @board.save 
      @message = "Board created."
      render :create, status: :created
    else
      @message = "Board not created."
      render 'api/v1/shared/error', status: :not_acceptable
    end
  end

  def index
    if Organization.exists?(params[:organization_id])
      @boards = Organization.find(params[:organization_id]).boards
      @message = "Organization's boards retrieved."
    else
      @boards = current_user.boards
      @message = "Your boards were retrieved."
    end

    render :index, status: :ok
  end

  def show
    @board = current_user.all_accessible_boards.find(params[:id])
    @message = "Board retrieved."

    render :show, status: :ok
  end

  private

  def board_params
    params.permit(:owner_id, :owner_type, :title)
  end
end