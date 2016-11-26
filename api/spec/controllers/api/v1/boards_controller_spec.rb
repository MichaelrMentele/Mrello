require 'rails_helper'

describe Api::V1::BoardsController do 
  describe "POST create" do 
    context "Valid params" do 
      it "creates a board" do 
        expect(Board.count).to eq(1)
      end

      it "associates the board with a user"
      it "sets @message"
      it "sets @board"
      it "renders create response"
    end

    context "Invalid params" do 
      it "does not create a board"
      it "sets @message"
      it "renders an error response"
    end
  end

  describe "GET show"
  describe "GET index"
end