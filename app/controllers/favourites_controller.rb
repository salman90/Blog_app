class FavouritesController < ApplicationController
before_action :authenticate_user!



  def index
    @posts = current_user.favourite_posts
  end

  def create
    post = Post.find params[:post_id]
    fav = Favourite.new(post: post, user: current_user)
    if fav.save
      redirect_to post_path(post), notice: "thanks for favourating"
    else
      redirect_to post_path(post), alert: "Unable to faver"
    end
  end

    def destroy
      fav = current_user.favourites.find params[:id]
      post = Post.find params[:post_id]
      fav.destroy
      redirect_to post_path(post)
    end



end
