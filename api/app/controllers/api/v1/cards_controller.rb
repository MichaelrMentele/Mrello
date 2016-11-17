class Api::V1::CardsController < Api::V1::ProtectedResourcesController
  
  def create
    @card = Card.new(card_params)
    if @card.save
      render json: {
        status: :ok,
        message: "SUCCESS: Card created.", 
        card: @card 
      }
    else
      render json: {
        status: :not_acceptable, 
        message: "FAILURE: Card not created. Invalid inputs." 
      }
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
    params.require(:card).permit(:title, :list_id, :description)
  end
end