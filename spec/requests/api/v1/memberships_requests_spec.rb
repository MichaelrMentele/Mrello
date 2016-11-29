require 'rails_helper'

describe "Memberships API" do
  let!(:alice) { Fabricate(:user) }
  let!(:acme) { Fabricate(:organization) }

  before do 
    allow_any_instance_of(ApplicationController).to receive(:authenticate_request)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(alice)
  end

  describe "POST create JSON response" do 
    context "successful response" do 
      before do 
        post '/api/v1/memberships', params: { user_id: alice.id, organization_id: acme.id }
      end

      it "returns a message" do 
        expect(json['message']).to be_present
      end

      it "returns the membership" do 
        expect(json['membership']).to be_present
      end

      it "returns the membership information" do 
        expect(json['membership']['user_id']).to be_present
        expect(json['membership']['organization_id']).to be_present
      end
    end

    context "error response" do 
      before do 
        post '/api/v1/memberships', params: { }
      end

      it "returns a message" do 
        expect(json['message']).to be_present
      end
    end
  end

  describe "PATCH update JSON response" do
    let!(:acme_member) { Fabricate(:membership, user: alice, organization: acme) }

    context "successful update" do      
      before do 
        patch "/api/v1/memberships/#{acme_member.id}", params: { approved: true }
      end

      it "returns a message" do 
        expect(json['message']).not_to be_nil
      end

      it "returns the serialized membership" do 
        expect(json['membership']).not_to be_nil
        expect(json['membership']['user_id']).to be_present
        expect(json['membership']['organization_id']).to be_present
      end
    end

    context "unsuccessful update" do 
      before do 
        patch "/api/v1/memberships/#{acme_member.id}", params: { approved: "tree" }
      end

      it "returns a message" do 
        expect(json['message']).to be_present
      end
    end
  end

  describe 'GET index JSON response' do
    let!(:bob) { Fabricate(:user) }

    before do 
      Fabricate(:membership, user: alice, organization: acme) 
      Fabricate(:membership, user: bob, organization: acme) 
    end

    context "organizations memberships" do 
      before do 
        get '/api/v1/memberships', params: { organization_id: acme.id }
      end

      it "returns serialized memberships" do 
        expect(json['memberships'].length).to eq(2)
      end

      it "returns a message" do 
        expect(json['message']).to be_present
      end
    end

    context "current users memberships" do 
      before do 
        get '/api/v1/memberships', params: { }
      end

      it "returns serialized memberships" do 
        expect(json['memberships'].length).to eq(1)
      end

      it "returns a message" do 
        expect(json['message']).to be_present
      end
    end
  end
end

