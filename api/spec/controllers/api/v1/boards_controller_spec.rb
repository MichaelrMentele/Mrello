require 'rails_helper'

describe Api::V1::BoardsController do 
  let!(:alice) { Fabricate(:user) }

  before do 
    request.env["HTTP_ACCEPT"] = "application/json"
    request.env["CONTENT_TYPE"] = "application/json"

    allow_any_instance_of(ApplicationController).to receive(:authenticate_request)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(alice)
  end

  describe "POST create" do 
    context "user" do 
      context "valid inputs" do 
        before do 
          post :create, params: { }
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

        it "renders create template" do 
          expect(response).to render_template :create
        end

        it "returns a created status" do 
          expect(response).to have_http_status(:created)
        end
      end

      # Note: expected to fail because we cannot have invalid inputs for board creation
      context "invalid inputs" do 
        it "sets @message" do 
          expect(assigns(:message)).to be_present
        end

        it "renders error template" do 
          expect(response).to render_template 'api/v1/shared/error'
        end

        it "returns a failed status" do 
          expect(response).to have_http_status(:not_acceptable)
        end
      end
    end

    context "organization" do 
      context "valid inputs" do 
        let!(:organization) { Fabricate(:organization) }
        before do 
          post :create, params: { }
        end

        it "creates a board" do 
          expect(Board.count).to eq(1)
        end

        it "associates the board with an organization" do 
          expect(acme.boards.count).to eq(1)
        end

        it "sets @message" do 
          expect(assigns(:message)).to be_present
        end

        it "sets @board" do 
          expect(assigns(:board)).to be_present
        end

        it "renders create template" do 
          expect(response).to render_template :create
        end

        it "returns a created status" do 
          expect(response).to have_http_status(:created)
        end
      end

      # Note: expected to fail because we cannot have invalid inputs for board creation
      context "invalid inputs" do 
        it "sets @message" do 
          expect(assigns(:message)).to be_present
        end

        it "renders error template" do 
          expect(response).to render_template 'api/v1/shared/error'
        end

        it "returns a failed status" do 
          expect(response).to have_http_status(:not_acceptable)
        end
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