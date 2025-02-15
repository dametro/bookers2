class BooksController < ApplicationController
  def index
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
    @your_user = current_user 
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
    else 
      puts "失敗...... 。book updateできず."
    end
    redirect_to book_path(@book.id)  
  end

  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      puts "成功！book create."
    else 
      puts "失敗...... 。book createできず."
    end
    #いずれにしても/booksに飛ばす
    redirect_to books_path
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
