require 'rails_helper'

describe Api::V1::OrganizationsController do 
  before do 
    request.env["HTTP_ACCEPT"] = "application/json"
    request.env["CONTENT_TYPE"] = "application/json"
  end

  describe "POST create" do 
    context "current user is an admin" do 
      let!(:alice) { Fabricate(:user, admin: true) }

      before do 
        allow_any_instance_of(ApplicationController).to receive(:authenticate_request)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(alice)
      end

      context "does NOT have an organizaton" do 

        context "valid inputs" do 
          before do 
            post :create, params: { admin: alice, title: "Acme" }
          end

          it "sets @org" do 
            expect(assigns(:org)).to be_present
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
            post :create, params: { admin: alice, title: "" }
          end

          it "does NOT set @org" do 
            expect(assigns(:org)).not_to be_present
          end

          it "sets @message" do 
            expect(assigns(:message)).to eq("Organization not created.")
          end

          it "renders error" do 
            expect(response).to render_template 'api/v1/shared/error'
          end

          it "responds with not acceptable status" do 
            expect(response).to have_http_status(:not_acceptable)
          end
        end
      end

      context "current user has an organization and valid inputs" do 
        let!(:alice) { Fabricate(:user, admin: true) }
        let!(:acme) { Fabricate(:organization, admin: alice) }

        before do 
          alice.update_attributes(organization: acme)
          post :create, params: { admin: alice, title: "Acme" }
        end

        it "does NOT set @org" do 
          expect(assigns(:org)).not_to be_present
        end

        it "sets @message" do 
          expect(assigns(:message)).to eq("You already have an organization.")
        end

        it "renders error" do 
          expect(response).to render_template 'api/v1/shared/error'
        end

        it "responds with not acceptable status" do 
          expect(response).to have_http_status(:not_acceptable)
        end
      end 
    end

    context "current user is not an admin" do 
      let!(:alice) { Fabricate(:user) }

      before do 
        allow_any_instance_of(ApplicationController).to receive(:authenticate_request)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(alice)
      end

      context "valid inputs" do 
        before do 
          post :create, params: { title: "Acme" }
        end

        it "does NOT set @org" do 
          expect(assigns(:org)).not_to be_present
        end

        it "sets @message" do 
          expect(assigns(:message)).to eq("You must be an admin to do that.")
        end

        it "renders error" do 
          expect(response).to render_template 'api/v1/shared/error'
        end

        it "responds with not authorized status" do 
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end

  end

  describe "GET index" do 
    it "sets @orgs"
    it "sets @message"
    it "renders index"
    it "responds with accepted status"
  end
end