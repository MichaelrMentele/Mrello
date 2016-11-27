require 'rails_helper'

describe "organizations API" do 
  let!(:alice) { Fabricate(:user) }

  before do 
    allow_any_instance_of(ApplicationController).to receive(:authenticate_request)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(alice)
  end

  describe "POST create JSON response" do 
    
    context "successful response" do 
      before do 
        post '/api/v1/organizations', params: { title: "Acme" }
      end

      it "returns a message" do 
        expect(json['message']).to be_present
      end

      it "returns the organization" do 
        expect(json['organization']).to be_present
      end

      it "returns the organization information" do 
        expect(json['organization']['title']).to be_present
      end
    end

    context "error response" do 
      before do 
        post '/api/v1/organizations', params: { title: "Acme" }
      end

      it "returns a message" do 
        expect(json['message']).to be_present
      end
    end
  end

  describe "GET index JSON response" do 
    before do 
      Fabricate(:organization)
      Fabricate(:organization)
      get '/api/v1/organizations'
    end

    it "returns a message" do 
      expect(json['message']).to be_present
    end

    it "returns organizations" do 
      expect(json['organizations']).to be_present
    end
  end

  describe "GET show JSON response" do 
    it "isn't tested yet"
  end
end