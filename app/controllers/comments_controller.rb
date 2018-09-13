class CommentsController < ApplicationController

  def create
    if params[:plan_id]
      @plan = Plan.find(params[:plan_id])
      @comment = @plan.comments.build(comment_params)
      @comment.member = current_member
      if @comment.save
        flash[:notice] = "plan留言建立"
        redirect_to @plan
      else
        redirect_to request.referrer, alert: @comment.errors.full_messages.to_sentence
      end
    else
      @post = Post.find(params[:post_id])
      @comment = @post.comments.build(comment_params)
      @comment.member = current_member
      if @comment.save
        flash[:notice] = "post留言建立"
        redirect_to @post
      else
        redirect_to request.referrer, alert: @comment.errors.full_messages.to_sentence
      end
    end
  end

  def destroy
    # if params[:plan_id]
      # @plan = Plan.find(params[:plan_id])
      @comment = Comment.find(params[:id])
      @comment.destroy
      flash[:notice] = "#{@comment.commentable_type}_comment was deleted"
      redirect_back(fallback_location: root_path)
    # else
      # @comment = Comment.find(params[:id])
      # @comment.destroy
      # redirect_back(fallback_location: root_path)
    # end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
