require 'rails_helper'

describe Api::V1::JoinRequestsController do 
  describe "POST create" do 
    let!(:alice) { Fabricate(:user) }
    let!(:bob) { Fabricate(:user) }
    let!(:alpha) { Fabricate(:organization, admin: alice) }

    context "valid inputs" do 
      before do 
        post :create, params: { user_id: bob.id, organization_id: alpha.id }
      end

      it "creates a join request" do 
        expect(JoinRequest.count).to eq(1)
      end

      it "sets @request" do 
        expect(assigns(:join_request)).to be_present
      end
    end

    context "invalid inputs" do 
      before do 
        post :create, params: { user_id: alice.id }
      end

      it "does NOT create a join request" do 
        expect(JoinRequest.count).to eq(0)
      end
    end
  end

  describe "POST update" do
    let!(:alice) { Fabricate(:user) }
    let!(:bob) { Fabricate(:user) }
    let!(:alpha) { Fabricate(:organization, admin: alice) }

    context "approved join request" do 
      let!(:request) { Fabricate(:join_request, user: alice, organization: alpha) }

      before do
        post :update, params: { id: request.id, approved: true }
      end

      it "associates the user with the organization" do
        expect(alice.reload.organization.title).to eq(alpha.title)
      end

      it "updated the join request" do 
        expect(JoinRequest.first.approved).to eq(true)
      end

      it "sets @join_request" do 
        expect(assigns(:join_request)).to be_present
      end
    end
  end

  describe "POST destroy" do 
    it "deletes the join request"
  end

  describe "GET index" do 

  end
end