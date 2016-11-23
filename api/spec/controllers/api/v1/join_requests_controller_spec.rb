require 'rails_helper'

describe Api::V1::JoinRequestsController do
  before do 
    request.env["HTTP_ACCEPT"] = "application/json"
    request.env["CONTENT_TYPE"] = "application/json"

    ApplicationController.any_instance.stub(:authenticate_request)
    ApplicationController.any_instance.stub(:current_user).and_return(alice)
  end

  describe "POST update" do
    let!(:alice) { Fabricate(:user, admin: true) }
    let!(:bob) { Fabricate(:user) }
    let!(:alpha) { Fabricate(:organization, admin: alice) }

    context "approved join request" do 
      let!(:join_request) { Fabricate(:join_request, user: alice, organization: alpha) }

      before do
        post :update, params: { id: join_request.id, approved: true }
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

  describe "POST create" do 
    let!(:alice) { Fabricate(:user, admin: true) }
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

  describe "GET index" do 
    let!(:alice)    { Fabricate(:user, organization_id: 1, admin: true) }
    let!(:bob)      { Fabricate(:user) }
    let!(:charlie)  { Fabricate(:user) }

    let!(:alpha)    { Fabricate(:organization, admin: alice) }

    before do 
      Fabricate(:join_request, user: bob, organization: alpha)
      Fabricate(:join_request, user: charlie, organization: alpha)
    end

    context "current user is admin" do
      before do 
        get :index 
      end

      it "sets @join_requests" do 
        expect(assigns(:join_requests)).to be_present
      end 

      it "retrieves the current admin's organizations join requests" do 
        expect(assigns(:join_requests).count).to eq(2)
      end
    end

    context "current user is NOT an admin" do 
      before do 
        ApplicationController.any_instance.stub(:current_user).and_return(bob)
        get :index
      end

      it "sets @join_requests" do 
        expect(assigns(:join_requests)).to be_present
      end

      it "retrieves the current users requests" do 
        expect(assigns(:join_requests).count).to eq(1)
      end
    end
  end
end