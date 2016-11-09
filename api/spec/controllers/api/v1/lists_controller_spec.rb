require 'rails_helper'

describe Api::V1::ListsController do 

  describe "GET show" do 
    let(:alice) { Fabricate(:user, fullname: "Alice Doe") }
    let(:todo_list) { Fabricate(:list, user: alice) }
    before do 
      set_current_user(alice)
      request.env["HTTP_ACCEPT"] = "application/json"
      request.env["CONTENT_TYPE"] = "application/json"
      get :show, params: { id: todo_list.id }
    end

    it "sets @list" do 
      expect(assigns(:list)).to be_present
    end 
    
  end

  describe "POST create" do 
    context "with valid params" do 
      let(:alice) { Fabricate(:user, fullname: "Alice Doe") }
      before do 
        set_current_user(alice)
        post :create, params: { list: { title: "Todos", user_id: alice.id } }
      end

      it "creates a list" do 
        expect(List.count).to eq(1)
      end
      it "associates it with the user" do 
        expect(List.first.user.fullname).to eq("Alice Doe")
      end
      it "returns a success status" do 
        expect(response).to be_successful
      end
    end

    context "with invalid params" do 
      let(:alice) { Fabricate(:user, fullname: "Alice Doe") }
      before do 
        set_current_user(alice)
        post :create, params: { list: { user_id: alice.id } }
      end

      it "does not create a list" do 
        expect(List.count).to eq(0)
      end

      it "returns a fail status" do 
        expect(response).not_to be_successful
      end
    end
  end
end