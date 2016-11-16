class Api::V1::CardsController < Api::V1::ProtectedResourcesController
  def create
    @card = Card.new(card_params.merge(list_id: params[:list_id]))
    if @card.save
      render json: 
        { status: "SUCCESS", message: "Card created.", card: @card },
        status: :ok
    else
      render json:
        { status: "FAILURE", message: "Card not created. Invalid inputs." },
        status: 406
    end
  end

  def index
    if params[:list_id]
      @cards = List.find(params[:list_id]).cards
    else
      @cards = Cards.all
    end
  end

  def show
    @card = Card.find(params[:id])
  end

  private

  def card_params
    params.require(:card).permit(:title, :description)
  end
end