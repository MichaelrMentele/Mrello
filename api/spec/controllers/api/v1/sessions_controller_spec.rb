require "rails_helper"

describe Api::V1::SessionsController do 
  describe "POST create" do 

    context "and user exists" do 
      let!(:alice) { Fabricate(:user) }

      context "with valid credentials" do
        before do 
          post :create, params: { email: alice.email, password: alice.password }
        end

        it "authenticates the credentials" do 
          expect(assigns(:auth)).to be_present
        end

        it "authenticates successfully" do 
          expect(assigns(:user)).to be_present
          expect(assigns(:token)).to be_present
        end

        it "renders the session" 
      end

      context "invalid credentials" do
        before do 
          post :create, params: { email: alice.email, password: "" }
        end

        it "authenticates the credentials" do 
          expect(assigns(:auth)).to be_present
        end

        it "authenticates UNsuccessfully" do 
          expect(assigns(:user)).not_to be_present
          expect(assigns(:token)).not_to be_present
        end

        it "renders an error message"
      end
    end

    context "user DOES NOT exist" do 
      before do 
        post :create, params: { email: "some@email.com", password: "pass" }
      end

      it "renders an error message"
    end
  end

end