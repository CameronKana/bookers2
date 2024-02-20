class UsersController < ApplicationController
  def new
     @user = User.new
  end

  def create
    @user = User.new(book_params)
    if @user.save
      flash[:notice] = "Book was successfully created."
      redirect_to user_path(@user.id)
    else
      flash[:notice] = "投稿に失敗しました。"
      render :new
    end
     redirect_to user_path(user.id)
  end

  def index
     @users = User.all
     @user = current_user
     @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end


  def edit
    is_matching_login_user
    @user = User.find(params[:id])

  end

  def update
    is_matching_login_user
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user)
    flash[:notice] = "Book was successfully updated."
    else
     render :edit
    end
  end


  def destroy
    user = User.find(params[:id])  # データ（レコード）を1件取得
    user.destroy  # データ（レコード）を削除
    # redirect_to '/users'  # 投稿一覧画面へリダイレクト
  end

  private
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  def user_params
    # params.require(:book).permit(:title, :body)
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end