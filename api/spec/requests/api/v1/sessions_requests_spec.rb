require "rails_helper"

# Tests the response content of the controller as opposed to the logic of the controller
describe "sessions API" do 
  describe "POST create response" do 
    context "with valid login" do
      let(:alice) { Fabricate(:user) }

      before do 
        post '/api/v1/sessions', params: { email: alice.email, password: alice.password }
      end

      it "returns a success status" do
        expect(response).to be_successful
      end

      it "returns a JSON web token" do 
        expect(JSON.parse(response.body)["session_token"]).to be_present
      end
    end

    context "with invalid login" do
      let(:alice) { Fabricate(:user) }

      before do 
        post '/api/v1/sessions', params: { email: alice.email }
      end

      it "is NOT successful" do 
        expect(response).not_to be_successful
      end

      it "does NOT return a JSON web token" do 
        expect(JSON.parse(response.body)[:session_token]).not_to be_present
      end
    end

    context "user DOES NOT exist" do 
      before do 
        post '/api/v1/sessions', params: { email: "some@email.com", password: "pass" }
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