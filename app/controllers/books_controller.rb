class BooksController < ApplicationController
  def index
    @book = Book.new #create成功時のリダイレクトでviewにNilエラーが出ると嫌だから

    @books = Book.all
    @new_book = Book.new
    #左上プロフィール用
    @your_user = current_user 
  end

  def show
    #投稿フォーム:render new_book用
    @new_book = Book.new
    #詳細表示用
    @book = Book.find(params[:id])
    #左上プロフィール用  
    @posted_user = User.find(@book.user_id)
  end

  def edit
    @book= Book.find(params[:id])
    if current_user.id == @book.user.id
      puts "編集可:あなたのuser id と 作成者のuser id が 一致しました"
    else
      puts "編集不可:あなたのuser id と 作成者のuser id は 一致しませんでした！"
      redirect_to books_path
    end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)

    if @book.update(book_params)
      puts "成功！book update."
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)  
    else 
      puts "失敗...... 。book updateできず."
      render :edit
      #edit表示に必要な情報変数は@bookのみ、renderでいい
    end
    
  end

  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    #いずれにしても/books(index)に飛ばす...違う！books/idか
    if @book.save
      puts "成功！book create."
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else 
      puts "失敗...... 。book createできず."
      # @book.error渡したいからrender
      # books#indexに必要な情報はここで用意してあげる
      @books = Book.all
      @new_book = Book.new
      @your_user = current_user 
      render :index
    end

  end

  def destroy
    #バリデーションは未だ
    @book = Book.find(params[:id])
    if @book.destroy
      puts "@book 破壊！ destroyed!"
    else
      puts "@book 破壊に失敗！！"
    end
    redirect_to books_path
  end



  # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
