require 'rails_helper'

describe Api::V1::BoardsController do 
  let!(:alice) { Fabricate(:user, fullname: "Alice Doe") }

  before do 
    request.env["HTTP_ACCEPT"] = "application/json"
    request.env["CONTENT_TYPE"] = "application/json"

    allow_any_instance_of(ApplicationController).to receive(:authenticate_request)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(alice)
  end

  describe "POST create" do 
    context "Valid params" do 
      before do 
        post :create, params: { admin: alice }
      end

      it "creates a board" do 
        expect(Board.count).to eq(1)
      end

      it "associates the board with a user" do 
        expect(alice.board).to be_present
      end

      it "sets @message" do 
        expect(assigns(:message)).to be_present
      end

      it "sets @board" do 
        expect(assigns(:board)).to be_present
      end

      it "renders create response" do 
        expect(response).to render_template 'api/v1/boards/create'
      end
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