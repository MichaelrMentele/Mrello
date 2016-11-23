require 'rails_helper'

describe "Cards API" do 
  describe "shows a card" do 
    let!(:alice) { Fabricate(:user, fullname: "Alice Doe") }
    let!(:todo_list) { Fabricate(:list, user: alice) }
    let!(:card) { Fabricate(:card, list: todo_list) }

    before do 
      sign_in(alice)
      binding.pry
      get api_v1_card_path(card.id)
    end

    it "returns a success message" do 
      expect(json['message']).to match("SUCCESS")
    end

    it "returns the serialized card" do 
      expect(json['card']).not_to be_nil
    end
  end

  describe "creating a card" do 
    let(:alice) { Fabricate(:user, fullname: "Alice Doe") }
    let!(:todo_list) { Fabricate(:list, user: alice) }

    context "with valid inputs" do 
      before do 
        sign_in(alice)
        post '/api/v1/cards', params: { card: { title: "Todo", list_id: todo_list.id } }
      end

      it "returns a success message" do 
        expect(json['message']).to match("SUCCESS")
      end

      it "returns the serialized card" do 
        expect(json['card']).not_to be_nil
      end
    end

    context "with invalid inputs" do 
      before do 
        sign_in(alice)
        post '/api/v1/cards', params: { card: { list_id: todo_list.id } }
      end

      it "returns an error message" do 
        expect(json['message']).to match("FAILURE ")
      end
    end
  end
end