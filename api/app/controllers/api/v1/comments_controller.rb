class Api::V1::CommentsController < Api::V1::ProtectedResourcesController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render json: 
        { status: "SUCCESS", message: "Comment created.", comment: @comment },
        status: :ok
    else
      render json:
        { status: "FAILURE", message: "Comment not created. Invalid inputs." },
        status: :not_acceptable
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:payload, :card_id)
  end
end