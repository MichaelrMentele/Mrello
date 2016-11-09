require 'rails_helper'

describe Api::V1::UsersController do 
  describe "POST create" do 
    context "with valid params" do 
      before do 
        post :create, params: { user: { fullname: "Alice Doe", email: "alice@test.com", password: "test" } }
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
        post :create, params: { user: { fullname: "Alice Doe"} }
      end

      it "does not create an obj" do 
        expect(User.count).to eq(0)
      end
      it "does not return a success status" do 
        expect(response).not_to be_successful
      end
    end
  end
end