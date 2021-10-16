class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end
  
  def create
  @user = User.new(user_params)
  end

  def edit
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def destroy
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)

  end

end
