require 'rails_helper'

describe Api::V1::ListsController do 
  let!(:alice) { Fabricate(:user, fullname: "Alice Doe") }

  before do 
    request.env["HTTP_ACCEPT"] = "application/json"
    request.env["CONTENT_TYPE"] = "application/json"

    allow_any_instance_of(ApplicationController).to receive(:authenticate_request)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(alice)
  end

  describe "POST create" do 
    context "with valid params" do 
      before do 
        post :create, params: { title: "Todos", user_id: alice.id }
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

      it "associates it with the user" do 
        expect(List.first.user.fullname).to eq("Alice Doe")
      end

      it "returns a create status" do 
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid params" do 
      before do 
        post :create, params: { list: { user_id: alice.id } }
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
    let(:list) { Fabricate(:list, user: alice) }

    context "with valid params" do 
      before do 
        post :update, params: { id: list.id, title: "Todos" }
      end

      it "updates the list" do 
        expect(List.first.title).to eq("Todos")
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

      it "returns a fail status" do 
        expect(response).not_to be_successful
      end
    end
  end

  describe "POST destroy" do 
    let!(:bob) { Fabricate(:user) }
    let!(:list_a) { Fabricate(:list, user: alice) }
    let!(:list_b) { Fabricate(:list, user: bob) }

    context "with another users list" do 
      it "does not destroy another users list" do 
        post :destroy, params: { id: list_b.id }
        expect(List.count).to eq(2)
      end
    end

    it "destroys the users own list" do 
      post :destroy, params: { id: list_a.id }

      expect(List.count).to eq(1)
    end  
    it "returns successfully" do 
      post :destroy, params: { id: list_a.id }

      expect(response).to be_successful
    end
  end

  describe "GET index" do 
    it "sets @lists" do
      Fabricate(:list, user: alice)
      Fabricate(:list, user: alice)
      
      get :index
      expect(assigns(:lists)).to be_present
    end
  end

  describe "GET show" do 
    let(:todo_list) { Fabricate(:list, user: alice) }
    before do 
      get :show, params: { id: todo_list.id }
    end

    it "sets @list" do 
      expect(assigns(:list)).to be_present
    end 
  end
end