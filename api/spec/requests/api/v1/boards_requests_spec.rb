require 'rails_helper'

describe "board API" do 
  describe "GET show JSON response" do 
    let!(:alice) { Fabricate(:user, fullname: "Alice Doe") }
    let!(:board) { Fabricate(:board, owner: alice) }

    before do 
      get api_v1_board_path(board.id)
    end

    it "returns a message" do 
      expect(json['message']).not_to be_nil
    end

    it "returns the serialized board" do 
      expect(json['board']).not_to be_nil
    end
  end

  describe "POST create JSON response" do 
    let(:alice) { Fabricate(:user, fullname: "Alice Doe") }

    context "with valid inputs" do 
      before do 
        sign_in(alice)
        post '/api/v1/boards', params: { board: { owner_id: alice.id } }
      end

      it "returns a success message" do 
        expect(json['message']).not_to be_nil
      end
      it "returns the serialized board" do 
        expect(json['board']).not_to be_nil
      end
    end

    context "with invalid inputs" do 
      before do 
        sign_in(alice)
        post '/api/v1/boards', params: { board: { } }
      end

      it "returns an error message" do 
        expect(json['message']).not_to be_nil
      end
    end
  end
end