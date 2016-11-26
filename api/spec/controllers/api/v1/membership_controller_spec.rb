require 'rails_helper'

describe Api::V1::MembershipsController do
  before do 
    request.env["HTTP_ACCEPT"] = "application/json"
    request.env["CONTENT_TYPE"] = "application/json"

    allow_any_instance_of(ApplicationController).to receive(:authenticate_request)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(alice)
  end

  describe "POST create" do 
    let!(:alice) { Fabricate(:user) }
    let!(:bob) { Fabricate(:user) }
    let!(:acme) { Fabricate(:organization) }

    context "valid inputs" do 
      before do 
        post :create, params: { user_id: bob.id, organization_id: acme.id }
      end

      it "creates an unapproved membership" do 
        expect(Membership.count).to eq(1)
      end

      it "sets @membership" do 
        expect(assigns(:membership)).to be_present
      end

      it "does not approve the membership" do 
        expect(Membership.first.approved).to eq(false)
      end

      it "renders created template" do 
        expect(response).to render_template :create
      end

      it "responds with created status" do 
        expect(response).to have_http_status(:created)
      end
    end

    context "invalid inputs" do 
      before do 
        post :create, params: { user_id: alice.id }
      end

      it "does NOT create a membership" do 
        expect(Membership.count).to eq(0)
      end

      it "renders the error template" do 
        expect(response).to render_template 'api/v1/shared/error'
      end

      it "responds with unacceptable status" do 
        expect(response).to have_http_status(:not_acceptable)
      end
    end
  end

  describe "POST update" do
    let!(:alice) { Fabricate(:user) }
    let!(:acme) { Fabricate(:organization) }
    let!(:acme_member) { Fabricate(:membership, user: alice, organization: acme) }

    context "to approve the membership" do 
      before do
        post :update, params: { id: acme_member.id, approved: true }
      end

      it "associates the user with the organization" do
        expect(alice.reload.organizations.count).to eq(1)
      end

      it "updated the membership" do 
        expect(Membership.first.approved).to eq(true)
      end

      it "sets @membership" do 
        expect(assigns(:membership)).to be_present
      end

      it "renders the update template" do 
        expect(response).to render_template :update
      end

      it "responds with accepted status" do 
        expect(response).to have_http_status(:accepted)
      end
    end

    context "invalid inputs" do 
      before do 
        post :update, params: { id: acme_member.id, user_id: "hello" }
      end

      it "does NOT update the membership" do 
        expect(Membership.first.user.id).to eq(alice.id)
      end

      it "renders the error template" do 
        expect(response).to render_template 'api/v1/shared/error'
      end

      it "responds with unacceptable status" do 
        expect(response).to have_http_status(:not_acceptable)
      end
    end
  end

  describe "GET index" do 
    let!(:alice)    { Fabricate(:user) }
    let!(:bob)      { Fabricate(:user) }
    let!(:charlie)  { Fabricate(:user) }

    let!(:acme)    { Fabricate(:organization) }

    before do 
      Fabricate(:membership, user: alice, organization: acme)
      Fabricate(:membership, user: bob, organization: acme)
      Fabricate(:membership, user: charlie, organization: acme)
    end

    context "retrieving current users memberships" do
      before do 
        get :index 
      end

      it "sets @memberships" do 
        expect(assigns(:memberships)).to be_present
      end 

      it "retrieves the current users memberships" do 
        expect(assigns(:memberships).count).to eq(1)
      end

      it "renders the index template" do 
        expect(response).to render_template :index
      end

      it "responds with successful status" do 
        expect(response).to have_http_status(:ok)
      end
    end

    context "retrieving organizations memberships" do 
      before do 
        get :index, params: { organization_id: acme.id }
      end

      it "sets @memberships" do 
        expect(assigns(:memberships)).to be_present
      end

      it "retrieves the organizations memberships" do 
        expect(assigns(:memberships).count).to eq(3)
      end

      it "renders the index template" do 
        expect(response).to render_template :index
      end

      it "responds with successful status" do 
        expect(response).to have_http_status(:ok)
      end
    end
  end
end