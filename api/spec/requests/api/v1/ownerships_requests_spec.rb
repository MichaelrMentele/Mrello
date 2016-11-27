require 'rails_helper'

describe "Ownerships API" do 
  let!(:alice) { Fabricate(:user) }

  before do 
    allow_any_instance_of(ApplicationController).to receive(:authenticate_request)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(alice)
  end

  describe "POST create JSON response" do 
    context "User creates an ownership" do 
      before do 
        post 'api/v1/ownerships', params: { user_id: alice.id }
      end

      it "has a message" do 
        expect(json['message']).to be_present
      end

      it "has a created status" do 
        expect(json[''])
      end

      it "has an ownership"
    end
  end
end