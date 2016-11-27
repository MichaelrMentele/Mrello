require 'rails_helper'

describe "Lists API" do 
  let!(:alice) { Fabricate(:user) }
  let!(:alice_board) { Fabricate(:board, owner: alice) }

  before do 
    allow_any_instance_of(ApplicationController).to receive(:authenticate_request)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(alice)
  end
  
  describe "POST create JSON response" do 
    context "with valid inputs" do 
      before do 
        post '/api/v1/lists', params: { title: "Todos", board_id: alice_board.id}
      end

      it "returns a success message" do 
        expect(json['message']).not_to be_nil
      end

      it "returns the serialized list" do 
        expect(json['list']).not_to be_nil
      end
    end

    context "with invalid inputs" do 
      before do 
        post '/api/v1/lists', params: { title: "" }
      end

      it "returns an error message" do 
        expect(json['message']).not_to be_nil
      end
    end
  end

  describe 'POST destroy' do
    let(:list) { Fabricate(:list, board: alice_board) }

    context "list exists on current owner" do 
      before do 
        delete "/api/v1/lists/#{list.id}"
      end

      it "returns a success message" do 
        expect(json['message']).not_to be_nil
      end

      it "returns the serialized list" do 
        expect(json['list']).not_to be_nil
      end
    end

    context "list does NOT exist on current user" do 
      before do 
        delete "/api/v1/lists/#{list.id}"
      end

      it "returns an error message" do 
        expect(json['message']).not_to be_nil
      end
    end

    context "list exists on current users organization" do 
      it "isn't"
    end
  end

  describe 'PATCH update JSON response' do
    let(:list) { Fabricate(:list, board: alice_board) }

    context "valid inputs" do 
      before do 
        patch "/api/v1/lists/#{list.id}", params: { title: "Lala" }
      end

      it "returns a success message" do 
        expect(json['message']).not_to be_nil
      end

      it "returns the serialized list" do 
        expect(json['list']).not_to be_nil
      end
    end

    context "invalid inputs" do 
      before do 
        patch "/api/v1/lists/#{list.id}", params: { title: "" }
      end

      it "returns an error message" do 
        expect(json['message']).not_to be_nil
      end
    end
  end

  describe "GET index JSON response" do 
    let!(:todo_list) { Fabricate(:list, board: alice_board) }

    context "current users lists" do 
      before do 
        get "/api/v1/lists"
      end

      it "returns a message" do 
        expect(json['message']).not_to be_nil
      end

      it "returns the serialized lists" do 
        expect(json['lists']).not_to be_nil
        expect(json['lists'].length).to eq(1)
      end
    end

    context "current users organization's lists" do 
      let!(:acme) { Fabricate(:organization) }
      let!(:acme_membership) { Fabricate(:membership, user: alice, organization: acme) }
      let!(:acme_board) { Fabricate(:board, owner: acme) }

      before do 
        Fabricate(:list, board: acme_board)
        Fabricate(:list, board: acme_board)

        get "/api/v1/lists", params: { organization_id: acme.id }
      end

      it "returns a message" do 
        expect(json['message']).not_to be_nil
      end

      it "returns the serialized list" do 
        expect(json['lists']).not_to be_nil
        expect(json['lists'].length).to eq(2)
      end
    end
  end

  describe "GET show JSON response" do 
    let!(:todo_list) { Fabricate(:list, board: alice_board) }

    before do 
      get "/api/v1/lists/#{todo_list.id}"
    end

    it "returns a message" do 
      expect(json['message']).not_to be_nil
    end

    it "returns the serialized list" do 
      expect(json['list']).not_to be_nil
    end
  end
end