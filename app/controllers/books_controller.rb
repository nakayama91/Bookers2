class BooksController < ApplicationController



  def index
    @books = Book.all
    @newbook = Book.new
    @user = current_user
  end

  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have updated user successfully."
      redirect_to book_path(@book)
    else
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to book_path(@book)
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
    redirect_to book_path(@book)
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
