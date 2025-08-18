class CategoriesController < ApplicationController
  def index
    @categories = Category.includes(:todos).all
    @category   = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: "Category created."
    else
      @categories = Category.all
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path, notice: "Category deleted."
  end

  private
  def category_params
    params.require(:category).permit(:name, :color)
  end
end
