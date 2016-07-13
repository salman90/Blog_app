class CommentsController < ApplicationController
  def create
    @comment  = Comment.new comment_params
     @post = Post.find params[:post_id]
     @comment.post = @post
     if @comment.save
       CommentsMailer.notify_post_owner(@comment).deliver_now
       redirect_to post_path(@post), notice: "comment created"
     else
       render "/posts/show"
     end
   end

   def destroy
     post = Post.find params[:post_id]
    comment  = Comment.find params[:id]
    comment.destroy
    redirect_to post_path(post), notice: "comment is deleted"

  end
  private
  def comment_params
    params.require(:comment).permit(:body)

  end
end
