require 'rails_helper'

describe Api::V1::CardsController do 
  before do 
    request.env["HTTP_ACCEPT"] = "application/json"
    request.env["CONTENT_TYPE"] = "application/json"

    allow_any_instance_of(ApplicationController).to receive(:authenticate_request)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(alice)
  end

  describe 'GET index' do
    let!(:alice) { Fabricate(:user) }
    let!(:alice_board) { Fabricate(:board, owner: alice) }
    let!(:alice_list_a) { Fabricate(:list, board: alice_board) }
    let!(:alice_list_b) { Fabricate(:list, board: alice_board) }

    before do 
      Fabricate(:card, list: lista)
      Fabricate(:card, list: lista)
      Fabricate(:card, list: listb)

      post :index, params: { list_id: lista.id }
    end

    it "sets cards to all cards for a given list" do 
      expect(assigns(:cards).length).to eq(2)
    end

    it "returns a success status" do 
      expect(response).to be_successful
    end

    it "returns a message" do 
      expect(response.message).to be_present
    end
  end

  describe 'POST destroy' do 
    let!(:alice) { Fabricate(:user) }
    let!(:lista) { Fabricate(:list, user_id: alice.id) }

    before do 
      Fabricate(:card, list: lista)
      post :destroy, params: { id: Card.first.id, list_id: lista.id }
    end

    it "deletes the card" do 
      expect(Card.count).to eq(0)
    end

    it "returns a success status" do 
      expect(response).to be_successful
    end

    it "returns a message" do 
      expect(response.message).to be_present
    end
  end

  describe 'POST update' do 
    let!(:alice) { Fabricate(:user) }
    let!(:lista) { Fabricate(:list, user_id: alice.id) }

    context "with valid params" do 
      before do 
        Fabricate(:card, list: lista)
        post :update, params: { id: Card.first.id, title: "Unique" }
      end

      it "updates the card" do 
        expect(Card.first.title).to eq("Unique")
      end

      it "returns a success status" do 
        expect(response).to be_successful
      end
    end

    context "with invalid params" do 
      before do 
        post :create, params: { card: { list_id: lista.id } }
      end

      it "does NOT create a card" do 
        expect(Card.count).to eq(0)
      end

      it "does NOT return a success status" do 
        expect(response).not_to be_successful
      end
    end
  end

  describe "POST create" do 
    let!(:alice) { Fabricate(:user) }
    let!(:lista) { Fabricate(:list, user_id: alice.id) }

    context "with valid params" do 
      before do 
        post :create, params: { title: "CardA", list_id: lista.id }
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

      it "does NOT create a card" do 
        expect(Card.count).to eq(0)
      end

      it "does NOT return a success status" do 
        expect(response).not_to be_successful
      end
    end
  end

  describe "GET show" do 
    let(:alice) { Fabricate(:user, fullname: "Alice Doe") }
    let(:todo_list) { Fabricate(:list, user: alice) }
    let(:card) { Fabricate(:card, list: todo_list) }

    before do 
      request.env["HTTP_ACCEPT"] = "application/json"
      request.env["CONTENT_TYPE"] = "application/json"
      get :show, params: { id: card.id }
    end

    it "sets @card" do 
      expect(assigns(:card)).to be_present
    end 

    it "returns a message" do 
      expect(response.message).to be_present
    end

    it "returns a success status" do 
      expect(response).to be_successful
    end
  end
end