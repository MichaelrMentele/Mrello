require 'rails_helper'

describe Api::V1::MembershipsController do
  before do 
    request.env["HTTP_ACCEPT"] = "application/json"
    request.env["CONTENT_TYPE"] = "application/json"

    allow_any_instance_of(ApplicationController).to receive(:authenticate_request)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(alice)
  end

  describe "POST update" do
    let!(:alice) { Fabricate(:user, admin: true) }
    let!(:bob) { Fabricate(:user) }
    let!(:alpha) { Fabricate(:organization, admin: alice) }

    context "approved join request" do 
      let!(:membership) { Fabricate(:membership, user: alice, organization: alpha) }

      before do
        post :update, params: { id: membership.id, approved: true }
      end

      it "associates the user with the organization" do
        expect(alice.reload.organization.title).to eq(alpha.title)
      end

      it "updated the join request" do 
        expect(Membership.first.approved).to eq(true)
      end

      it "sets @membership" do 
        expect(assigns(:membership)).to be_present
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
        expect(Membership.count).to eq(1)
      end

      it "sets @request" do 
        expect(assigns(:membership)).to be_present
      end
    end

    context "invalid inputs" do 
      before do 
        post :create, params: { user_id: alice.id }
      end

      it "does NOT create a join request" do 
        expect(Membership.count).to eq(0)
      end
    end
  end

  describe "GET index" do 
    let!(:alice)    { Fabricate(:user, organization_id: 1, admin: true) }
    let!(:bob)      { Fabricate(:user) }
    let!(:charlie)  { Fabricate(:user) }

    let!(:alpha)    { Fabricate(:organization, admin: alice) }

    before do 
      Fabricate(:membership, user: bob, organization: alpha)
      Fabricate(:membership, user: charlie, organization: alpha)
    end

    context "retrieving current users memberships" do
      before do 
        get :index 
      end

      it "sets @memberships" do 
        expect(assigns(:memberships)).to be_present
      end 

      it "retrieves the current admin's organizations memberships" do 
        expect(assigns(:memberships).count).to eq(2)
      end
    end

    context "retrieving organizations memberships" do 
      before do 
        ApplicationController.any_instance.stub(:current_user).and_return(bob)
        get :index, params: { organization_id: alpha.id }
      end

      it "sets @memberships" do 
        expect(assigns(:memberships)).to be_present
      end

      it "retrieves the organizations memberships" do 
        expect(assigns(:memberships).count).to eq(2)
      end
    end
  end
end