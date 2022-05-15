class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @articles = @user.articles
  end
  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to articles_path, notice: "Your account was successfully updated."
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to articles_path, notice: "Welcome #{@user.username} in our community. We're glad you here!"
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end