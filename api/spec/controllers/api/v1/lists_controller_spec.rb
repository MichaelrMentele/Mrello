require 'rails_helper'

describe Api::V1::ListsController do 
  let!(:alice) { Fabricate(:user) }
  let!(:alice_board) { Fabricate(:board, owner: alice) }

  before do 
    request.env["HTTP_ACCEPT"] = "application/json"
    request.env["CONTENT_TYPE"] = "application/json"

    allow_any_instance_of(ApplicationController).to receive(:authenticate_request)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(alice)
  end

  describe "POST create" do 
    context "with valid params" do 
      before do 
        post :create, params: { title: "Todos", board_id: alice_board.id }
      end

      it "creates a list" do 
        expect(List.count).to eq(1)
      end

      it "sets @message" do 
        expect(assigns(:message)).to be_present
      end

      it "sets @list" do 
        expect(assigns(:list)).to be_present
      end

      it "renders the create template" do 
        expect(response).to render_template 'api/v1/lists/create'
      end

      it "associates it with the board" do 
        expect(List.first.board.id).to eq(alice_board.id)
      end

      it "returns a create status" do 
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid params" do 
      before do 
        post :create, params: { title: "" }
      end

      it "sets @message" do 
        expect(assigns(:message)).to be_present
      end

      it "renders the error template" do 
        expect(response).to render_template 'api/v1/shared/error'
      end

      it "does not create a list" do 
        expect(List.count).to eq(0)
      end

      it "returns a fail status" do 
        expect(response).not_to be_successful
      end
    end
  end

  describe "POST update" do 
    let(:list) { Fabricate(:list, board: alice_board) }

    context "with valid params" do 
      before do 
        post :update, params: { id: list.id, title: "Todos" }
      end

      it "updates the list" do 
        expect(List.first.title).to eq("Todos")
      end

      it "sets @message" do 
        expect(assigns(:message)).to be_present
      end

      it "sets @list" do 
        expect(assigns(:list)).to be_present
      end

      it "renders the update template" do 
        expect(response).to render_template 'api/v1/lists/update'
      end

      it "returns a success status" do 
        expect(response).to be_successful
      end
    end

    context "with invalid params" do 
      before do 
        post :update, params: { id: list.id, title: "" }
      end

      it "does NOT update the list" do 
        expect(List.first.title).not_to eq("Todos")
      end

      it "sets @message" do 
        expect(assigns(:message)).to be_present
      end

      it "renders the error template" do 
        expect(response).to render_template 'api/v1/shared/error'
      end

      it "returns a fail status" do 
        expect(response).not_to be_successful
      end
    end
  end

  describe "POST destroy" do 
    let!(:bob) { Fabricate(:user) }
    let!(:bob_board) { Fabricate(:board, owner: bob) }

    let!(:alice_list) { Fabricate(:list, board: alice_board) }
    let!(:bob_list) { Fabricate(:list, board: bob_board) }

    context "on another users list" do 
      before do 
        post :destroy, params: { id: bob_list.id }
      end

      it "does not destroy another users list" do 
        expect(List.count).to eq(2)
      end

      it "sets @message" do 
        expect(assigns(:message)).to be_present
      end

      it "renders error template" do 
        expect(response).to render_template 'api/v1/shared/error'
      end
    end

    context "valid delete" do 
      before do 
        post :destroy, params: { id: alice_list.id }
      end

      it "sets @message" do 
        expect(assigns(:message)).to be_present
      end

      it "sets @list" do 
        expect(assigns(:list)).to be_present
      end

      it "destroys the users own list" do 
        expect(List.count).to eq(1)
      end  

      it "returns successfully" do 
        expect(response).to be_successful
      end

      it "renders delete template" do 
        expect(response).to render_template 'api/v1/lists/destroy'
      end
    end
  end

  describe "GET index" do
    context "current users lists" do  
      before do 
        Fabricate(:list, board: alice_board)
        Fabricate(:list, board: alice_board)
        
        get :index, params: { board_id: alice_board.id }
      end

      it "sets @lists" do
        expect(assigns(:lists)).to be_present
        expect(assigns(:lists).length).to eq(2)
      end

      it "sets @message" do 
        expect(assigns(:message)).to be_present
      end

      it "renders index" do 
        expect(response).to render_template :index
      end

      it "responds successfully" do 
        expect(response).to be_successful
      end
    end

    context "organization's lists" do  
      let!(:acme) { Fabricate(:organization) }
      let!(:acme_membership) { Fabricate(:membership, user: alice, organization: acme)}
      let!(:acme_board) { Fabricate(:board, owner: acme) }

      before do 
        Fabricate(:list, board: acme_board)
        Fabricate(:list, board: acme_board)
        
        get :index, params: { board_id: acme_board.id }
      end

      it "sets @lists" do
        expect(assigns(:lists)).to be_present
        expect(assigns(:lists).count).to eq(2)
      end

      it "sets @message" do 
        expect(assigns(:message)).to be_present
      end

      it "renders index" do 
        expect(response).to render_template :index
      end

      it "responds successfully" do 
        expect(response).to be_successful
      end
    end
  end

  describe "GET show" do 
    let(:todo_list) { Fabricate(:list, board: alice_board) }
    before do 
      get :show, params: { id: todo_list.id }
    end

    it "sets @list" do 
      expect(assigns(:list)).to be_present
    end 

    it "sets @message" do 
      expect(assigns(:message)).to be_present
    end

    it "renders show" do 
      expect(response).to render_template :show
    end
  end
end