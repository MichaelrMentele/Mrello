require 'rails_helper'

describe "Lists API" do 
  let!(:alice) { Fabricate(:user) }
  let!(:alice_ownership) { Fabricate(:ownership, owner: alice) }
  let!(:alice_board) { Fabricate(:board, ownership: alice_ownership) }

  before do 
    allow_any_instance_of(ApplicationController).to receive(:authenticate_request)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(alice)
  end
  
  describe "POST create JSON response" do 
    context "with valid inputs" do 
      before do 
        post '/api/v1/lists', params: { title: "Todos", board_id: alice_board.id}
      end

      it "returns a success message" do 
        expect(json['message']).not_to be_nil
      end

      it "returns the serialized list" do 
        expect(json['list']).not_to be_nil
      end
    end

    context "with invalid inputs" do 
      before do 
        post '/api/v1/lists', params: { title: "" }
      end

      it "returns an error message" do 
        expect(json['message']).not_to be_nil
      end
    end
  end

  describe 'POST destroy' do
    
  end

  describe 'PATCH update JSON response' do
    let(:list) { Fabricate(:list, board: alice_board) }

    context "valid inputs" do 
      before do 
        patch "/api/v1/lists/#{list.id}", params: { title: "Lala" }
      end

      it "returns a success message" do 
        expect(json['message']).not_to be_nil
      end

      it "returns the serialized list" do 
        expect(json['list']).not_to be_nil
      end
    end

    context "invalid inputs" do 
      before do 
        patch "/api/v1/lists/#{list.id}", params: { title: "" }
      end

      it "returns an error message" do 
        expect(json['message']).not_to be_nil
      end
    end
  end

  describe "GET index JSON response" do 
    it "isn't"
  end

  describe "GET show JSON response" do 
    let!(:todo_list) { Fabricate(:list, board: alice_board) }

    before do 
      get "/api/v1/lists/#{todo_list.id}"
    end

    it "returns a message" do 
      expect(json['message']).not_to be_nil
    end

    it "returns the serialized list" do 
      expect(json['list']).not_to be_nil
    end
  end
end