class CommentsController < ApplicationController
  def create
    @commentable = Post.find(params[:comment][:post_id]) if params[:comment][:post_id]
    @comment = @commentable.comments.build(comment_params)

    if @comment.save
      flash[:success] = "Comment submited"
    else
      flash[:danger] = "Comment failed"
    end

    redirect_to @commentable
  end

  private

    def comment_params
      params.require(:comment).permit(:author,:content)
    end
end
