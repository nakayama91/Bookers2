class BooksController < ApplicationController



  def index
    @books = Book.all
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to user_path(id: current_user)
    else
      render index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def destroy
  end

  private

  def book_params
    params.permit(:title, :body)
  end

end
