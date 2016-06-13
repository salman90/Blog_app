class CategoriesController < ApplicationController
  before_action :find_category, only: [:show, :edit, :update, :destroy]
  def new
    @category = Category.new
  end
  def create
    @category = Category.new category_params
    if @category.save
      flash[:notice]= "category created successfully"
      redirect_to category_path(@category)
    else
      flash[:alert] = "category can't be saved"
      render :new
    end
  end

  def show
  end


  def index
    @categories = Category.order(created_at: :desc)
  end

  def edit
  end

  def update
    if @category.update category_params
      flash[:notice] = "you're category have been updated"
      redirect_to category_path(@category)
    else
      flash[:alert] = "category could not be updated"
      render :edit
    end
  end

  def destroy
    @category.destroy
    flash[:notice] = "your category was deleted"
    redirect_to categories_path
  end






private

  def category_params
  params.require(:category).permit(:title)
  end

  def find_category
    @category = Category.find params[:id]
  end









end
