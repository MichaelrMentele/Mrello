class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_request

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render json: 
        {message: "Comment created.", comment: @comment },
        status: :ok
    else
      render json:
        {message: "Comment not created. Invalid inputs." },
        status: :not_acceptable
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:payload, :card_id)
  end
end