class CategoriesController < ApplicationController
  before_action :require_admin, except: %i[index show]
  
  def index
    @categories = Category.paginate(page: params[:page], per_page: 5).order(created_at: :desc)
  end

  def show
    @category = Category.find(params[:id])
    @articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category, notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to @category, notice: "Category name was successfully updated."
    else
      render :edit
    end
  end


  private

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !(logged_in? && current_user.admin?)
      redirect_to categories_path, alert: 'You are not authorized.'
    end
  end
end
