require 'rails_helper'

describe Api::V1::CardsController do 
  describe "POST create" do 
    let!(:alice) { Fabricate(:user) }
    let!(:lista) { Fabricate(:list, user_id: alice.id) }

    context "with valid params" do 
      before do 
        post :create, params: { card: { title: "CardA", list_id: lista.id } }
      end

      it "creates a card" do 
        expect(Card.count).to eq(1)
      end
      it "associates the card with a list" do 
        expect(List.first.cards.count).to eq(1)
      end
      it "returns a success status" do 
        expect(response).to be_successful
      end
    end

    context "with invalid params" do 
      before do 
        post :create, params: { card: { list_id: lista.id } }
      end

      it "does not create a card" do 
        expect(Card.count).to eq(0)
      end
      it "does not return a success status" do 
        expect(response).not_to be_successful
      end
    end
  end

  describe "GET show"
  describe "GET index"
end