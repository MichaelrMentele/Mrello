class Api::V1::BoardsController < ApplicationController
  before_action :authenticate_request

  def create
    @organization = Organization.find(params[:organization_id]) if params[:organization_id]
    if @organization.member?(current_user)

    end

    @board = Board.new(board_params.to_h.merge(owner_id: @owner.id))

    if @board.save 
      @message = "Board created."
      render :create, status: :created
    else
      @message = "Board not created."
      render 'api/v1/shared/error', status: :not_acceptable
    end
  end

  def show
    if current_user.boards.exists?(params[:id])
      @board = current_user.boards.find(params[:id])
      @message = "Board retrieved."
      render :show, status: :ok
    else
      @message = "You do not have access to that board."
      render 'api/v1/shared/error', status: :unauthorized
    end
  end

  private

  def board_params
  end
end