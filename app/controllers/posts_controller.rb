class PostsController < ApplicationController

  def index
    @posts_public = Post.where(public: true)
    @posts_draft = Post.where(public: false)
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
        redirect_to drafts_member_path(current_member)
        # redirect_to posts_path
      else
        flash.new[:alert] = @post.errors.full_messages.to_sentence
        render :index
      end
    else
      @post.public = true
      if @post.save
        redirect_to post_path(@post)
      else
        flash.new[:alert] = @post.errors.full_messages.to_sentence
        render :index
      end
    end
  end

  def update
    @post = Post.find(params[:id])
    if params[:commit] == "Submit"
      @post.public = true
      if @post.update(post_params)
        redirect_to posts_path
      else
        flash.new[:alert] = @post.errors.full_messages.to_sentence
        render :index
      end
    else
      @post.public = false
      if @post.update(post_params)
        redirect_to drafts_member_path(current_member)
      else
        flash.new[:alert] = @post.errors.full_messages.to_sentence
        render :index
      end
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :public, :authority)
  end
end
