class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.member = current_member
    if @comment.save
      flash[:notice] = "留言建立"
      redirect_to @post
    else
      redirect_to request.referrer, alert: @comment.errors.full_messages.to_sentence
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
