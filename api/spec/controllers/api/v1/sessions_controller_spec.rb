require "rails_helper"

describe Api::V1::SessionsController do 
  before do 
    request.env["HTTP_ACCEPT"] = "application/json"
    request.env["CONTENT_TYPE"] = "application/json"
  end

  describe "POST create" do 

    context "and user exists" do 
      let!(:alice) { Fabricate(:user) }

      context "with valid credentials" do
        before do 
          post :create, params: { email: alice.email, password: alice.password }
        end

        it "authenticates the credentials" do 
          expect(assigns(:auth)).to be_present
        end

        it "sets @user and @token" do 
          expect(assigns(:user)).to be_present
          expect(assigns(:token)).to be_present
        end

        it "sets @message" do 
          expect(assigns(:message)).to be_present
        end

        it "renders the session" do
          expect(response).to render_template 'api/v1/sessions/create'
        end

        it "returns a created status" do
          expect(response).to have_http_status(:created)
        end
      end

      context "invalid credentials" do
        before do 
          post :create, params: { email: alice.email, password: "" }
        end

        it "authenticates the credentials" do 
          expect(assigns(:auth)).to be_present
        end

        it "authenticates UNsuccessfully" do 
          expect(assigns(:user)).not_to be_present
          expect(assigns(:token)).not_to be_present
        end

        it "sets @message" do 
          expect(assigns(:message)).to be_present
        end

        it "the status is NOT accetable" do 
          expect(response).not_to have_http_status(:not_acceptable)
        end

        it "renders an error message" do 
          expect(response).to render_template 'api/v1/sessions/error'
        end
      end
    end

    context "user DOES NOT exist" do 
      before do 
        post :create, params: { email: "some@email.com", password: "pass" }
      end

      it "sets @message" do 
        expect(assigns(:message)).to be_present
      end

      it "the status is NOT accetable" do 
        expect(response).to have_http_status(:not_acceptable)
      end

      it "renders an error message" do 
        expect(response).to render_template 'api/v1/sessions/error'
      end
    end
  end

end