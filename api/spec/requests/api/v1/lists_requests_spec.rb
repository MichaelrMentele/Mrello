require 'rails_helper'

describe "Lists API" do 
  describe "shows a list" do 
    let!(:alice) { Fabricate(:user, fullname: "Alice Doe") }
    let!(:todo_list) { Fabricate(:list, user: alice) }
    let!(:card) { Fabricate(:card, list: todo_list) }
    before do 
      get api_v1_list_path(todo_list.id)
    end
    it "returns a success message" do 
      json = JSON.parse(response.body)
      expect(json['message']).not_to be_nil
    end
    it "returns the serialized list" do 
      json = JSON.parse(response.body)
      expect(json['list']).not_to be_nil
    end
    it "returns all cards on the list" do 
      json = JSON.parse(response.body)
      expect(json['cards']).not_to be_nil
    end
  end
  describe "creating a list" do 
    let(:alice) { Fabricate(:user, fullname: "Alice Doe") }

    context "with valid inputs" do 
      before do 
        post '/api/v1/lists', params: { list: { title: "Todos", user_id: alice.id } }
      end

      it "returns a success message" do 
        json = JSON.parse(response.body)
        expect(json['message']).not_to be_nil
      end
      it "returns the serialized list" do 
        json = JSON.parse(response.body)
        expect(json['list']).not_to be_nil
      end
    end

    context "with invalid inputs" do 
      before do 
        post '/api/v1/lists', params: { list: { user_id: alice.id } }
      end

      it "returns an error message" do 
        json = JSON.parse(response.body)
        expect(json['message']).not_to be_nil
      end
    end
  end
end