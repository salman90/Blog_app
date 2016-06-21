class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    if @post.save
      flash[:notice] = "Post created successfully"
      redirect_to post_path(@post)
      # render json: params
    else
      flash[:alert] = "post can't be created"
      render :new
    end

  end

  def show
    @comment = Comment.new
  end
  def index
    @posts = Post.order(created_at: :desc)
  end
  def edit
  end


  def update
    if @post.update post_params
      flash[:notice] = "the post was updated "
      redirect_to post_path(@post)
    else
      flash[:alert] = "Post can't be updated"
      render :edit
    end

  end

  def destroy
    @post.destroy
    flash[:notice]= "your post was deleted"
    redirect_to posts_path
  end


  private
  def post_params
    params.require(:post).permit(:title, :body)
  end
  def find_post
    @post = Post.find params[:id]
  end

  def authenticate_user! #is to make sure that the user can't change anything if he's not signed in 
    redirect_to new_session_path, alert: "Please sign in."unless user_signed_in?
  end
end
