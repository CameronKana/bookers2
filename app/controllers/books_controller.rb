class BooksController < ApplicationController
  def new
     @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def index
     @books = Book.all
     @book = Book.new
     @user = current_user
  end

  def show
     @book = Book.find(params[:id])
     @user = @book.user
     @books = @user.books
     @book_new = Book.new
  end


  def edit
    is_matching_login_user
    @book = Book.find(params[:id])

  end

  def update
    is_matching_login_user
    @book = Book.find(params[:id])
    if @book.update(book_params)
    redirect_to book_path(@book)
    flash[:notice] = "Book was successfully updated."
    else
     render :edit
    end
  end

  def destroy

    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    redirect_to '/books'  # 投稿一覧画面へリダイレクト
  end

  private
  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user.id == current_user.id
      redirect_to books_path
    end
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end
end