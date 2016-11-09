require 'rails_helper'

describe Api::V1::CommentsController do 
  describe "POST create" do 
    let!(:alice) { Fabricate(:user) }
    let!(:list) { Fabricate(:list, user_id: alice.id) }
    let!(:card) { Fabricate(:card, list_id: list.id) }

    context "with valid params" do 
      before do 
        set_current_user(alice)
        post :create, params: { comment: { payload: "This is a comment", card_id: card.id } }
      end

      it "creates a comment" do 
        expect(Comment.count).to eq(1)
      end
      it "associates the comment with a card" do 
        expect(Card.first.comments.count).to eq(1)
      end
      it "returns a success status" do 
        expect(response).to be_successful
      end
    end

    context "with invalid params" do 
      before do 
        set_current_user(alice)
        post :create, params: { comment: { list_id: list.id } }
      end

      it "does not create a comment" do 
        expect(Comment.count).to eq(0)
      end
      it "does not return a success status" do 
        expect(response).not_to be_successful
      end
    end
  end
end