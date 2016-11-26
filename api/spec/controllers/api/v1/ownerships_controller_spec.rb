require 'rails_helper'

describe Api::V1::OwnershipsController do
  let!(:alice) { Fabricate(:user) }
  let!(:acme) { Fabricate(:organization) }
  let!(:acme_membership) { Fabricate(:membership, organization: acme, user: alice) }

  before do 
    request.env["HTTP_ACCEPT"] = "application/json"
    request.env["CONTENT_TYPE"] = "application/json"

    allow_any_instance_of(ApplicationController).to receive(:authenticate_request)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(alice)
  end

  describe "POST create" do 
    context "valid owner" do
      context "is a user" do 
        before do 
          post :create, params: { user_id: alice.id }
        end

        it "creates an ownership" do 
          expect(Ownership.count).to eq(1)
        end

        it "associates a user" do 
          expect(alice.ownerships.count).to eq(1)
        end

        it "sets @message" do 
          expect(assigns(:message)).to be_present
        end

        it "renders create response" do 
          expect(response).to render_template 'api/v1/ownerships/create'
        end
      end

      context "is an organization" do
        before do 
          post :create, params: { organization_id: acme.id }
        end

        it "creates an ownership" do 
          expect(Ownership.count).to eq(1)
        end

        it "associates an organization" do 
          expect(Organization.first.ownerships.count).to eq(1)
        end

        it "sets @message" do 
          expect(assigns(:message)).to be_present
        end

        it "renders create response" do 
          expect(response).to render_template 'api/v1/ownerships/create'
        end
      end
    end

    context "invalid owner" do 
      before do 
        post :create, params: {}
      end

      it "does NOT create an ownership" do 
        expect(Ownership.count).to eq(0)
      end

      it "sets @message" do 
        expect(assigns(:message)).to be_present
      end

      it "renders an error" do 
        expect(response).to render_template 'api/v1/shared/error'
      end
    end
  end
end