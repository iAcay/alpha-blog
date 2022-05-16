class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :require_user, only: %i[edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  
  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to articles_path, notice: "Welcome #{@user.username} in our community. We're glad you here!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Your account was successfully updated."
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Account was successfully deleted."
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
    redirect_to @user, notice: "You are not authorized to access this page." unless @user == current_user
  end
end