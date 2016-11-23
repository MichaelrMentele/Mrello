require 'rails_helper'

describe Api::V1::UsersController do 
  before do 
    request.env["HTTP_ACCEPT"] = "application/json"
    request.env["CONTENT_TYPE"] = "application/json"
  end

  describe "POST create" do 
    context "with valid params" do 
      before do 
        post :create, params: { fullname: "Alice Doe", email: "alice@test.com", password: "test" }
      end

      it "creates an obj" do 
        expect(User.count).to eq(1)
      end

      it "sets @user" do 
        expect(assigns(:user)).to be_present
      end

      it "sets @message" do 
        expect(assigns(:message)).to be_present
      end

      it "returns a created status" do 
        expect(response).to have_http_status(:created)
      end

      it "renders create template" do 
        expect(response).to render_template "api/v1/users/create"
      end
    end

    context "with invalid params" do 
      before do 
        post :create, params: { fullname: "Alice Doe"}
      end

      it "does not create an obj" do 
        expect(User.count).to eq(0)
      end

      it "sets @message" do 
        expect(assigns(:message)).to be_present
      end
      
      it "returns not acceptable status" do 
        expect(response).to have_http_status(:not_acceptable)
      end

      it "renders error template" do 
        expect(response).to render_template "api/v1/shared/error"
      end
    end
  end

  describe "PATCH update" do 
    let!(:alice) { Fabricate(:user) }
    before do 
      ApplicationController.any_instance.stub(:authenticate_request)
      ApplicationController.any_instance.stub(:current_user).and_return(alice)
    end

    context "with valid params" do 
      let(:new_name) { "New"}
      before do 
        post :update, params: { id: alice.id, fullname: new_name }
      end

      it "modifies the object" do 
        expect(User.first.reload.fullname).to eq(new_name)
      end

      it "does not modify attributes not passed in" do 
        expect(User.first.reload.email).to eq(alice.email)
      end

      it "sets @user" do 
        expect(assigns(:user)).to be_present
      end

      it "sets @message" do 
        expect(assigns(:message)).to be_present
      end

      it "renders update" do
        expect(response).to render_template 'api/v1/users/update'
      end

      it "returns a success status" do 
        expect(response).to be_successful
      end
    end

    context "with invalid params" do 
      before do 
        post :update, params: { id: alice.id, fullname: ""}
      end

      it "sets @message" do 
        expect(assigns(:message)).to be_present
      end

      it "renders error template" do
        expect(response).to render_template 'api/v1/shared/error'
      end

      it "does not update an obj" do 
        expect(User.first.fullname).not_to eq("")
      end

      it "does not return a success status" do 
        expect(response).not_to be_successful
      end
    end
  end
end