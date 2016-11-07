require 'rails_helper'

describe Api::V1::UsersController do 
  describe "POST create" do 
    context "valid inputs" do 
      it "creates a user"
    end
  end

  describe "GET show" do 
    it "returns a 403 if not logged in"
    it "renders the users serialized json"
  end
end