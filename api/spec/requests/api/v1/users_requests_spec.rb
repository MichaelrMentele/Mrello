  require 'rails_helper'

describe "Users API" do 
  describe "creating a user" do
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
end

