require "rails_helper"

describe Api::V1::SessionsController do 
  let!(:alice) { Fabricate(:user) }
  describe "POST create" do 
    before do 
      post :create, params: { id: alice.id }
    end

    it "creates a session" do 
      expect(session[:user_id]).to be_present
    end
  end

  describe "DELETE destroy" do 
    before do
      set_current_user(alice)
      post :destroy
    end

    it "clears the session" do 
      expect(session[:user_id]).to be_nil
    end
  end
end