require "rails_helper"

# Tests the response content of the controller as opposed to the logic of the controller
describe "sessions API" do 
  describe "POST create JSON response" do 
    context "with valid login" do
      let(:alice) { Fabricate(:user) }

      before do 
        post '/api/v1/sessions', params: { email: alice.email, password: alice.password }
      end

      it "returns a JSON web token" do 
        expect(JSON.parse(response.body)["session_token"]).to be_present
      end

      it "returns a message" do 
        expect(JSON.parse(response.body)["message"]).to be_present
      end

      it "returns a user" do 
        expect(JSON.parse(response.body)["user"]).to be_present
      end

      it "returns safe user info" do 
        expect(JSON.parse(response.body)["user"]["fullname"]).to be_present
        expect(JSON.parse(response.body)["user"]).to have_key('admin')
      end

      it "it does not return UNsafe user info" do 
        expect(JSON.parse(response.body)["user"]["password"]).not_to be_present
        expect(JSON.parse(response.body)["user"]["password_digest"]).not_to be_present
        expect(JSON.parse(response.body)["user"]["email"]).not_to be_present
      end
    end

    context "with invalid login" do
      let(:alice) { Fabricate(:user) }

      before do 
        post '/api/v1/sessions', params: { email: alice.email }
      end

      it "returns a message" do 
        expect(JSON.parse(response.body)["message"]).to be_present
      end

      it "does NOT return a user" do 
        expect(JSON.parse(response.body)["user"]).not_to be_present
      end

      it "does NOT return a JSON web token" do 
        expect(JSON.parse(response.body)[:session_token]).not_to be_present
      end
    end

    context "user DOES NOT exist" do 
      before do 
        post '/api/v1/sessions', params: { email: "some@email.com", password: "pass" }
      end

      it "JSON contains a message" do 
        expect(JSON.parse(response.body)["message"]).to be_present
      end

      it "does NOT return a JSON web token" do 
        expect(JSON.parse(response.body)[:session_token]).not_to be_present
      end
    end
  end

end