class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  
  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
    @users = User.all
  end

  def show
    @book = Book.find(params[:id])
    @newbook = Book.new
    @user = @book.user
  end

  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice]="You have creatad book successfully."
      redirect_to book_path(@book)
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice]="Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
      flash[:notice]="Book was successfully destroyed."
    redirect_to books_path
  end

  private
    def book_params
      params.require(:book).permit(:title, :body)
    end

    def ensure_correct_user
      book = Book.find(params[:id])
      unless book.user == current_user
        redirect_to books_path
      end
    end

end