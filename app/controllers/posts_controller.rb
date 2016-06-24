class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  #we add the gam cancancan to make sure that the creater of the post is the only one can change it

  def new
    @post = Post.new
  end

  def create

    @post = Post.new post_params
    @post.user = current_user
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
    redirect_to root_path, alert: "access defined" unless can? :edit, @post
  end


  def update
     redirect_to root_path, alert: "access defined" unless can? :update, @post
    if @post.update post_params
      flash[:notice] = "the post was updated "
      redirect_to post_path(@post)
    else
      flash[:alert] = "Post can't be updated"
      render :edit
    end

  end

  def destroy
     redirect_to root_path, alert: "access defined" unless can? :destroy, @post
    @post.destroy
    flash[:notice]= "your post was deleted"
    redirect_to posts_path
  end


  private
  def post_params
    params.require(:post).permit(:title, :body, {tag_ids: []})
  end


  def find_post
    @post = Post.find params[:id]
  end

  def authenticate_user! #is to make sure that the user can't change anything if he's not signed in
    redirect_to new_session_path, alert: "Please sign in."unless user_signed_in?
  end
end
