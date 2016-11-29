class Api::V1::CardsController < ApplicationController
  before_action :authenticate_request
  before_action :check_access, only: [:destroy, :update, :show]

  def create
    @card = Card.new(card_params)
    if @card.save
      @message = "Card created."
      render :create, status: :created
    else
      @message = "Card not created. Invalid inputs." 
      render 'api/v1/shared/error', status: :not_acceptable
    end
  end

  def destroy
    @card = Card.find(params[:id]).destroy!
    @message = "Card deleted."
    render :destroy, status: :accepted # TODO: redundant to have any templates besides show and index
  end

  def update
    @card = Card.find(params[:id])
    if @card.update_attributes(card_params)
      @message = "Card updated."
      render :update, status: :accepted
    else
      @message = "Card not updated."
      render 'api/v1/shared/error', status: :not_acceptable
    end
  end

  def index
    if current_user.has_access_to("Lists", params[:list_id])
      @message = "Cards for list retrieved."
      @cards = List.find(params[:list_id]).cards
      render :index, status: :ok
    else
      @message = "You do not have access to the cards on that list."
      render 'api/v1/shared/error', status: :unauthorized
    end
  end

  def show
    @message = "Card returned"
    @card = Card.find(params[:id])
  end

  private

  def card_params
    params.permit(:title, :list_id)
  end
end