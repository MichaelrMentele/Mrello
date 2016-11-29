require 'rails_helper'

describe "Cards API" do 
  let!(:alice) { Fabricate(:user) }

  before do 
    allow_any_instance_of(ApplicationController).to receive(:authenticate_request)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(alice)
  end

  describe "GET show JSON response" do 
    let!(:alice_board) { Fabricate(:board, owner: alice) }
    let!(:alice_list) { Fabricate(:list, board: alice_board) }
    let!(:alice_card) { Fabricate(:card, list: alice_list) }

    before do 
      get "/api/v1/cards/#{alice_card.id}"
    end

    it "returns a success message" do 
      expect(json['message']).to be_present
    end

    it "returns the serialized card" do 
      expect(json['card']).not_to be_nil
    end
  end

  describe "POST create JSON response" do 
    let!(:alice_board) { Fabricate(:board, owner: alice) }
    let!(:alice_list) { Fabricate(:list, board: alice_board) }

    context "with valid inputs" do 
      before do 
        post '/api/v1/cards', params: { title: "Todo", list_id: alice_list.id }
      end

      it "returns a success message" do 
        expect(json['message']).to be_present
      end

      it "returns the serialized card" do 
        expect(json['card']).not_to be_nil
      end
    end

    context "with invalid inputs" do 
      before do 
        post '/api/v1/cards', params: { card: { list_id: alice_list.id } }
      end

      it "returns an error message" do 
        expect(json['message']).to be_present
      end
    end
  end
end