class BooksController < ApplicationController
  def show
  end

  def edit
  end

  def index
    @user =current_user
    @book = Book.new
    @books = Book.all
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice]="You have creatad book successfully."
      redirect_to book_path(@book)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
end
