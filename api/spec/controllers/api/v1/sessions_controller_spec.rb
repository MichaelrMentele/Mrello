require "rails_helper"

describe Api::V1::SessionsController do 
  describe "POST create" do 

    context "user exists" do 
      let!(:alice) { Fabricate(:user) }

      context "valid credentials" do
        before do 
          post :create, params: { email: alice.email, password: alice.password }
        end

        it "sets user" do 
          expect(assigns(:user)).to be_present
        end

        it "is successful" do 
          expect(response).to be_successful
        end

        it "returns a JSON web token" do 
          expect(JSON.parse(response.body)["session_token"]).to be_present
        end
      end

      context "invalid credentials" do
        before do 
          post :create, params: { email: alice.email, password: "" }
        end

        it "is NOT successful" do 
          expect(response).not_to be_successful
        end

        it "does NOT return a JSON web token" do 
          expect(JSON.parse(response.body)[:session_token]).not_to be_present
        end
      end
    end
    context "user DOES NOT exist" do 
      before do 
        post :create, params: { email: "some@email.com", password: "pass" }
      end

      it "is NOT successful" do 
        expect(response).not_to be_successful
      end

      it "does NOT return a JSON web token" do 
        expect(JSON.parse(response.body)[:session_token]).not_to be_present
      end
    end
  end
end