class PostsController < ApplicationController
  before_action :find_post

  def index
    if params[:id]
      @post = Post.find(params[:id])
    else
      @post = Post.new
    end
  end

  def create
    @post = current_member.posts.build(post_params)
    if params[:commit] == "Save Draft"
      @post.public = false
      if @post.save
        # redirect_to drafts_member_path(current_member)
        flash[:notice] = "儲存草稿"
        redirect_to posts_path
      else
        flash[:alert] = @post.errors.full_messages.to_sentence
        render :index
      end
    else
      @post.public = true
      if @post.save
        flash[:notice] = "發布"
        redirect_to post_path(@post)
      else
        flash[:alert] = @post.errors.full_messages.to_sentence
        render :index
      end
    end
  end

  def update
    @post = Post.find(params[:id])
    if params[:commit] == "Submit"
      @post.public = true
      if @post.update(post_params)
        flash[:notice] = "發布"
        redirect_to posts_path
      else
        flash.now[:alert] = @post.errors.full_messages.to_sentence
        render :index
      end
    else
      @post.public = false
      if @post.update(post_params)
        flash[:notice] = "儲存草稿"
        redirect_to posts_path
      else
        flash[:alert] = @post.errors.full_messages.to_sentence
        render :index
      end
    end
  end

  # def comment
  #   @post = post.find(params[:id])
  #   @comment.user = current_user
  #   @comment = @post.comments.build(comment_params)
  #   @comment.save!
  #   redirect_to post_path(@post)
  # end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  private

  # def comment_params
  #   params.require(:comment).permit(:content)
  # end

  def find_post
    @posts_public = Post.where(public: true)
    @posts_draft = Post.where(public: false)
  end

  def post_params
    params.require(:post).permit(:title, :content, :public, :authority, :tag_list)
  end
end
