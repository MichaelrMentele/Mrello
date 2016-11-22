require 'rails_helper'

describe Api::V1::UsersController do 
  describe "POST create" do 
    context "with valid params" do 
      before do 
        post :create, params: { fullname: "Alice Doe", email: "alice@test.com", password: "test" }
      end

      it "creates an obj" do 
        expect(User.count).to eq(1)
      end
      it "returns a success status" do 
        expect(response).to be_successful
      end
    end

    context "with invalid params" do 
      before do 
        post :create, params: { fullname: "Alice Doe"}
      end

      it "does not create an obj" do 
        expect(User.count).to eq(0)
      end
      it "does not return a success status" do 
        expect(response).not_to be_successful
      end
    end
  end

  describe "PATCH update" do 
    let!(:alice) { Fabricate(:user) }

    context "with valid params" do 
      let(:new_name) { "New"}
      before do 
        ApplicationController.any_instance.stub(:authenticate_request)
        ApplicationController.any_instance.stub(:current_user).and_return(alice)
        post :update, params: { id: alice.id, fullname: "New" }
      end

      it "modifies the object" do 
        expect(User.first.reload.fullname).to eq("New")
      end

      it "does not modify attributes not passed in" do 
        expect(User.first.reload.email).to eq(alice.email)
      end

      it "returns a success status" do 
        expect(response).to be_successful
      end
    end

    context "with invalid params" do 
      before do 
        post :update, params: { id: alice.id, fullname: ""}
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