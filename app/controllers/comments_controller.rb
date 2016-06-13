class CommentsController < ApplicationController
  before_action :find_comment, only: [:show, :edit, :update, :destroy]
  def new
    @comment = Comment.new
  end
  def  create
    @comment = Comment.new comment_params
    if @comment.save
      flash[:notice] = "your have created a comment"
      redirect_to comment_path(@comment)
    else
      flash[:alert] = "comment can't be created"
      render :new
    end
  end
    def show
    end

    def index
      @comments = Comment.order(created_at: :desc)
    end
    def edit
    end

    def update
      if @comment.update comment_params
        flash[:notice] = "the comment was updated"
        redirect_to comment_path(@comment)
      else
        flash[:alert] = "comment can't be updated"
        render :edit
      end
    end

    def destroy
      @comment.destroy
      flash[:notice] = "your comment was deleted successfully"
      redirect_to comments_path
    end 




private
  def comment_params
    params.require(:comment).permit(:body)
  end
  def find_comment
    @comment = Comment.find params[:id]
  end
end
