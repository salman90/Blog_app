class UsersController < ApplicationController
  def new
    @user = User.new
  end

    def create
    @user = User.new user_params
    if @user.save
      sign_in(@user)
      redirect_to root_path, notice: "You're now signed in"
    else
      render :new
    end
  end
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    user_params = params.require(:user).permit(:first_name, :last_name, :email, :current_password, :password, :password_confirmation)
    if current_user && @user.authenticate(user_params[:current_password]) && user_params[:current_password] !=  user_params[:password] # you check the current password and make sure it's not equal to the old
      user_params.delete(:current_password) #delete the current passworsd
      @user.update user_params
      redirect_to root_path, notice: "Account updated!"
    else
      flash[:alert] = "Unable to update account"
      render :edit
    end

    # Update without password
    # if @user.update user_params
    #   redirect_to root_path
    #   flash[:notice] = "Account updated"
    # else
    #   render :edit
    #   flash[:notice] = "Unable to update account"
    # end

    # if @user.update_attributes(user_params)
    # else
    #   render 'edit'
    # end
  end

  private
  def user_params
    user_params = params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :picture)
  end


end
