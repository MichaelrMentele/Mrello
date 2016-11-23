require 'rails_helper'

describe "Users API" do 
  describe "POST create response" do
    context "with valid inputs" do 
      before do 
        post '/api/v1/users', params: { user: { fullname: "Alice Doe", email: "alice@test.com", password: "pass" } }
      end

      it "returns a success message" do 
        json = JSON.parse(response.body)
        expect(json['message']).not_to be_nil
      end

      it "returns the serialized user" do 
        json = JSON.parse(response.body)
        expect(json['user']).not_to be_nil
      end
    end

    context "with invalid inputs" do 
      before do 
        post '/api/v1/users', params: { user: { fullname: "Alice Doe" } }
      end

      it "returns an error message" do 
        json = JSON.parse(response.body)
        expect(json['message']).not_to be_nil
      end
    end
  end

  describe "GET index response" do
    it "returns a success status" do 
      expect(response).to be_successful
    end

    it "returns a message" do 
      expect(response.message).to be_present
    end

    it "returns the users"
  end
end

