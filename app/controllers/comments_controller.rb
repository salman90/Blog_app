class CommentsController < ApplicationController
  def create
    @comment  = Comment.new comment_params
     @post = Post.find params[:post_id]
     @comment.post = @post
     @comment.user = current_user
     respond_to do |format|
       if @comment.save
         #  CommentsMailer.notify_post_owner(@comment).deliver_now
         format.html{redirect_to post_path(@post), notice: "comment created"}
         format.js{render :create_success}
       else
         format.html{render "/posts/show", alert: "something went wrong"}
         format.js {render :create_failure}
       end
     end
   end
   def edit
    @post = Post.find params[:post_id]
    @comment = Comment.find params[:id]
  end
  def update
    @post = Post.find params[:post_id]
    @comment = Comment.find params[:id]
    if @comment.update comment_params
      redirect_to post_path(@post)
    else
      render "/posts/show"
    end
  end
   def destroy
    @post = Post.find params[:post_id]
    @comment  = Comment.find params[:id]
    @comment.destroy
    respond_to do |format|
      format.html {redirect_to post_path(post), notice: "comment is deleted"}
      format.js {render }
    end
  end
  private
  def comment_params
    params.require(:comment).permit(:body)

  end
end
