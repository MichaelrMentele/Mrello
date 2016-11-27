require 'rails_helper'

describe Api::V1::OrganizationsController do 
  before do 
    request.env["HTTP_ACCEPT"] = "application/json"
    request.env["CONTENT_TYPE"] = "application/json"

    allow_any_instance_of(ApplicationController).to receive(:authenticate_request)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(alice)
  end

  describe "POST create" do 
    let!(:alice) { Fabricate(:user) }

    context "valid inputs" do 
      before do 
        post :create, params: { title: "Acme" }
      end

      it "creates an organization" do 
        expect(Organization.count).to eq(1)
      end

      it "creates an approved membership for the current user to the organization" do 
        expect(Membership.count).to eq(1)
        expect(alice.memberships.first.organization).to eq(Organization.first)
        expect(Membership.first.approved).to eq(true)
      end

      it "sets @organization" do 
        expect(assigns(:organization)).to be_present
      end

      it "sets @message" do 
        expect(assigns(:message)).to eq("Organization created.")
      end

      it "renders create" do 
        expect(response).to render_template 'api/v1/organizations/create'
      end

      it "responds with created status" do 
        expect(response).to have_http_status(:created)
      end
    end

    context "invalid inputs" do 
      before do 
        post :create, params: { title: "" }
      end

      it "does NOT create and organization" do 
        expect(Organization.count).to eq(0)
      end

      it "sets @message" do 
        expect(assigns(:message)).to eq("Organization creation failed.")
      end

      it "renders error" do 
        expect(response).to render_template 'api/v1/shared/error'
      end

      it "responds with not acceptable status" do 
        expect(response).to have_http_status(:not_acceptable)
      end
    end
  end

#     context "current user is not an admin" do 
#       let!(:alice) { Fabricate(:user) }

#       before do 
#         allow_any_instance_of(ApplicationController).to receive(:authenticate_request)
#         allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(alice)
#       end

#       context "valid inputs" do 
#         before do 
#           post :create, params: { title: "Acme" }
#         end

#         it "does NOT set @org" do 
#           expect(assigns(:org)).not_to be_present
#         end

#         it "sets @message" do 
#           expect(assigns(:message)).to eq("You must be an admin to do that.")
#         end

#         it "renders error" do 
#           expect(response).to render_template 'api/v1/shared/error'
#         end

#         it "responds with not authorized status" do 
#           expect(response).to have_http_status(:unauthorized)
#         end
#       end
#     end
#   end

#   describe "GET index" do 
#     let!(:alice) { Fabricate(:user, admin: true) }
#     let!(:bob) { Fabricate(:user, admin: true) }

#     before do 
#       allow_any_instance_of(ApplicationController).to receive(:authenticate_request)
#       allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(alice)
      
#       Fabricate(:organization, admin: alice)
#       Fabricate(:organization, admin: bob)

#       get :index
#     end

#     it "sets @organizations" do 
#       expect(assigns(:organizations)).to be_present
#       expect(assigns(:organizations).count).to eq(2)
#     end

#     it "sets @message" do 
#       expect(assigns(:message)).to be_present
#     end

#     it "renders index" do 
#       expect(response).to render_template 'api/v1/organizations/index'
#     end

#     it "responds with accepted status" do
#       expect(response).to have_http_status(:ok)
#     end
#   end

#   describe "GET show" do 
#     it "sets @message"
#     it "sets @organization"
#     it "renders show"
#   end
end