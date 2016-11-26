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
    context "User doesn't have a board" do 
      before do 
        post :create, params: { owner: alice }
      end

      it "creates a board" do 
        expect(Board.count).to eq(1)
      end

      it "associates the board with a user" do 
        expect(alice.boards.count).to eq(1)
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

    context "User already owns a board." do 
      before do 
        Fabricate(:board, owner: alice)
        post :create, params: { }
      end

      it "creates a board" do 
        expect(Board.count).to eq(2)
      end

      it "sets @message" do 
        expect(assigns(:message)).to be_present
      end

      it "renders create response" do 
        expect(response).to render_template 'api/v1/boards/create'
      end
    end
  end

  describe "GET show" do 
    context "if the board is the current users" do
      let!(:board) { Fabricate(:board, owner: alice) }
      before do 
        post :show, params: { id: board.id }
      end

      it "sets @message" do 
        expect(assigns(:message)).to be_present
      end

      it "sets @board" do 
        expect(assigns(:board)).to be_present
      end

      it "renders show response" do 
        expect(response).to render_template 'api/v1/boards/show'
      end
    end

    context "if the board is NOT the current users" do 
      let!(:bob) { Fabricate(:user) }
      let!(:board) { Fabricate(:board, owner: bob) }
      before do 
        get :show, params: { id: board.id }
      end

      it "sets @message" do 
        expect(assigns(:message)).to be_present
      end

      it "renders error response" do 
        expect(response).to render_template 'api/v1/shared/error'
      end
    end
  end

  describe "GET index" do 
    it "sets @message" do 

    end

    it "only shows boards for the current user" do 

    end

    it "sets @boards" do 

    end

    it "renders index response" do 

    end
  end
end