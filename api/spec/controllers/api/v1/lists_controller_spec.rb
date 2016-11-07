require 'rails_helper'

describe Api::V1::ListsController do 
  describe "POST create" do 
    context "with valid params" do 
      let(:alice) { Fabricate(:user, fullname: "Alice Doe") }
      before do 
        post api_v1_lists_path, params: { list: { title: "Todos", user: alice } }
      end

      it "creates a list" do 
        expect(List.count).to eq(1)
      end
      it "associates it with the user" do 
        expect(List.first.user.fullname).to eq("Alice Doe")
      end
      it "returns a success status" do 
        expect(response).to be_successful
      end
      it "returns the serialized list" do 
        expect(json['list']).not_to be_nil
      end
    end

    context "with invalid params" do 
      it "does not create a list"
      it "returns a fail status"
      it "returns an error message"
    end
  end
end