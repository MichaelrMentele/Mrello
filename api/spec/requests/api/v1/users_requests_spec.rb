require 'rails_helper'

describe "Users API" do 
  describe "creating a user" do
    context "with valid information" do  
      it "returns user information" do 
        post '/api/v1/users', params: { user: { fullname: 'Alice Doe' } }

        json = JSON.parse(response.body)

        expect(response).to be_successful
        expect(json['user']['fullname']).to eq("Alice Doe")
      end
    end
    context "with invalid information" do 
      it "returns an error status"
      it "returns a validation errors"
    end
  end
end