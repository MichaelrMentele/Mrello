require 'rails_helper'

describe "board API" do
  let(:alice) { Fabricate(:user) }

  before do 
    allow_any_instance_of(ApplicationController).to receive(:authenticate_request)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(alice)
  end

  describe "POST create JSON response" do 
    context "with valid inputs" do 
      before do 
        post '/api/v1/boards', params: { owner_type: "User", owner_id: alice.id }
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
        post '/api/v1/boards', params: { owner_id: 1 }
      end

      it "returns an error message" do 
        expect(json['message']).not_to be_nil
      end
    end
  end

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
end