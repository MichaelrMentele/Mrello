class Api::V1::BoardsController < ApplicationController
  before_action :authenticate_request

  def create
    @board = Board.new(board_params.to_h.merge(user_id: current_user.id))
    if @board.save
      @message = "Board created."
      render :create, status: :created
    else
      @message = "Board not created."
      render 'api/v1/shared/error', status: :not_acceptable
    end
  end

  def show
    @list = current_user.lists.find(params[:id])
    render :show, status: :ok
  end

  private

  def board_params
    # TODO: whitelist
    params.permit!
  end
end