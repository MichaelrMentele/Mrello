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

  def index
    if params[:list_id]
      @cards = List.find(params[:list_id]).cards
    else
      @cards = Card.all
    end
  end

  def show
    @card = Card.find(params[:id])
  end

  def destroy
    Card.destroy(params[:id])
    render json: 
      { status: "SUCCESS", message: "Card deleted." },
      status: :accepted
  end

  def update
    card = Card.find(params[:id])
    if card.update_attributes(card_params)
      render json: 
      { status: "SUCCESS", message: "Card updated.", card: card },
        status: :ok
    else
      render json: 
      { status: "FAILURE", message: "Card NOT updated.", card: card },
        status: :not_acceptable
    end
  end

  private

  def card_params
    params.permit(:title, :list_id)
  end
end