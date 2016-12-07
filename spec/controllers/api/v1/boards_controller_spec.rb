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
    context "valid inputs" do 
      before do 
        post :create, params: { owner_type: "User", owner_id: alice.id }
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

    context "invalid inputs" do 
      before do 
        post :create, params: { owner_id: alice.id }
      end

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

  describe 'GET index' do
    let!(:acme) { Fabricate(:organization) }
    before do 
      Fabricate(:membership, user: alice, organization: acme)

      Fabricate(:board, owner: acme)
      Fabricate(:board, owner: acme)

      Fabricate(:board, owner: alice)
    end

    context "as organization" do 
      before do 
        get :index, params: { organization_id: acme.id }
      end

      it "retrives the organizations boards" do 
        expect(assigns(:boards).length).to equal(2)
      end

      it "sets @message" do 
        expect(assigns(:message)).to be_present
      end

      it "sets @boards" do 
        expect(assigns).to be_present
      end

      it "renders boards index" do
        expect(response).to render_template :index
      end

      it "sets a success status" do 
        expect(response).to be_successful
      end
    end

    context "as user" do 
      before do 
        get :index
      end

      it "retrives the users boards" do 
        expect(assigns(:boards).length).to equal(1)
      end

      it "sets @message" do 
        expect(assigns(:message)).to be_present
      end

      it "sets @boards" do 
        expect(assigns).to be_present
      end

      it "renders boards index" do
        expect(response).to render_template :index
      end

      it "sets a success status" do 
        expect(response).to be_successful
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

      it "sets a success status" do 
        expect(response).to be_successful
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

      it "is not success status" do 
        expect(response).not_to be_successful
      end
    end
  end
end