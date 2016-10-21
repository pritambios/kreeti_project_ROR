class CategoriesController < ApplicationController
  before_action :require_admin, except: [:index, :show]
  before_action :get_category, only: [:edit, :update, :show, :destroy]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 3)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:success] = "Category was created successfully"
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def update
    if @category.update(category_params)
      flash[:success] = "Category name was successfully updated"
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def show
    @category_items = @category.items.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    flash[:danger] = "#{@category.name} and their items have been removed."
    @category.destroy
    redirect_to categories_path
  end

  private

  def get_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    return if current_user.admin?
    flash[:danger] = 'Only admins can perform that action.'
    redirect_to categories_path
  end
end
