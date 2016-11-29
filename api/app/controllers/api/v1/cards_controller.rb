class Api::V1::CardsController < ApplicationController
  before_action :authenticate_request

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
    # TODO: how does this work with organizations cards?
    if current_user.cards.exists?(params[:id])
      @card = Card.find(params[:id]) 
      @card.destroy!
      @message = "Card deleted."
      render :destroy, status: :accepted # TODO: redundant to have any templates besides show and index
    else
      @message = "You cannot delete a card you do not own."
      render 'api/v1/shared/error', status: :unauthorized
    end
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
    if params[:list_id]
      @cards = List.find(params[:list_id]).cards
    else
      @cards = current_user
    end
  end

  def show
    @card = Card.find(params[:id])
  end

  private

  def card_params
    params.permit(:title, :list_id)
  end
end