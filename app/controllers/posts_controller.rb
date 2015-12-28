class PostsController < ApplicationController
  before_action :set_post, only: [:show,:edit,:update,:destroy]

  def show
  end

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    if @post.save
      flash[:success] = "Post successfully created!"
      redirect_to @post
    else
      flash[:danger] = "Failed to create post"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post successfully updated!"
      redirect_to @post
    else
      flash[:danger] = "Failed to create post!"
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post Destroyed"
    redirect_to posts_path
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body)
    end

end
