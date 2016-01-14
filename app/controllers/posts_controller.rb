class PostsController < ApplicationController
  before_action :authenticate_admin!, except: [:show, :index]
  before_action :set_post, only: [:edit,:update,:destroy]

  def show
    @comment = Comment.new
    @post = Post.includes(:comments).find(params[:id])
  end

  def index
    @category = params[:category]
    @posts = post_feed @category
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    if @post.save
      flash[:success] = "Post successfully created!"

      #create tags from string separated by a ;
      params[:tags].split(";").each do |tag|
        @tag = Tag.find_or_create_by(content: tag.strip)
        Tagging.create(post_id: @post.id, tag_id: @tag.id)
      end

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
      params.require(:post).permit(:title, :body, :id)
    end

    def post_feed category
      posts = []
      if params[:category]
        marked  = Tagging.where(tag_id: Tag.find_by(content: params[:category])).includes(:post)
        marked.each { |mark| posts << mark.post }
      else
        posts = Post.all.order(created_at: :desc)
      end

      posts
    end


end
