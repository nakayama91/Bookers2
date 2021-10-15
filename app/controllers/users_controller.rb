class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @book = Book.new
#    @books = @user.books
  end

  def edit
  end

  def index
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)

  end

end
