class BooksController < ApplicationController
  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    #投稿フォーム:render new_book用
    @new_book = Book.new
    #詳細表示用
    @book = Book.find(params[:id])  
  end

  def edit
    user = Book.find(params[:id]).user
    if current_user.id == user.id
    else
      redirect_to books_path
    end

  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to books_path
  end

  def destroy
    @book = Book.find(params[:id])
    @book = destroy
    redirect_to books_path
  end



  # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
