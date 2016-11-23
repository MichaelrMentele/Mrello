require 'rails_helper'

describe "Users API" do 
  describe "POST create JSON response" do
    context "with valid inputs" do 
      before do 
        post '/api/v1/users', params: { fullname: "Alice Doe", email: "alice@test.com", password: "pass" }
      end

      it "returns a success message" do 
        expect(json['message']).not_to be_nil
      end

      it "returns the serialized user" do 
        expect(json['user']).not_to be_nil
        expect(json['user']['fullname']).not_to be_nil
        expect(json['user']['admin']).not_to be_nil
      end

      it "does NOT return private user information" do 
        expect(json['user']['email']).to be_nil
        expect(json['user']['password']).to be_nil
        expect(json['user']['password_digest']).to be_nil
      end
    end

    context "with invalid inputs" do 
      before do 
        post '/api/v1/users', params: { fullname: "Alice Doe" }
      end

      it "returns an error message" do 
        expect(json['message']).not_to be_nil
      end

      it "does NOT return a user" do 
        expect(json["user"]).not_to be_present
      end
    end
  end

  describe "PATCH update JSON response" do 
    let!(:alice) { Fabricate(:user) }
    before do 
      allow_any_instance_of(ApplicationController).to receive(:authenticate_request)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(alice)

      patch "/api/v1/users/#{alice.id}", params: { fullname: "Alice Doe" }
    end

    it "returns a success message" do 
      expect(json['message']).not_to be_nil
    end

    it "returns the serialized user" do 
      expect(json['user']).not_to be_nil
      expect(json['user']['fullname']).not_to be_nil
      expect(json['user']['admin']).not_to be_nil
    end

    it "does NOT return private user information" do 
      expect(json['user']['email']).to be_nil
      expect(json['user']['password']).to be_nil
      expect(json['user']['password_digest']).to be_nil
    end

    context "with invalid inputs" do 
      before do 
        patch "/api/v1/users/#{alice.id}", params: { fullname: "" }
      end

      it "returns an error message" do 
        expect(json['message']).not_to be_nil
      end

      it "does NOT return a user" do 
        expect(json["user"]).not_to be_present
      end
    end
  end
end

