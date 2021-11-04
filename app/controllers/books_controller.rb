class BooksController < ApplicationController



  def index
    @books = Book.includes(:favorited_users).
      sort {|a,b| 
        b.favorited_users.includes(:favorites).size <=> 
        a.favorited_users.includes(:favorites).size
      }
    @newbook = Book.new
    @user = current_user
  end

  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
    @book_comments = @book.book_comments
  end

  def create
    @newbook = Book.new(book_params)
    @books = Book.all
    @newbook.user_id = current_user.id
    @user = @newbook.user
    if @newbook.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@newbook)
    else
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to books_path
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
    else
      render :edit
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
