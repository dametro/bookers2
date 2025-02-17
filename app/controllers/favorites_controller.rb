class FavoritesController < ApplicationController


  # favorite は単数、bookに固有だから :idとして取得せず(できず) urlの :book_idを利用する
  def create
    book = Book.find(params[:book_id])
    # favorite = current_user.favorites.new(book_id: book.id)
    favorite = Favorite.new(book_id: book.id)
    favorite.user_id = current_user.id 
    
    puts "新しいfavoriteのデータ... #{favorite}, id:#{favorite.id}, user: #{favorite.user_id}, book: #{favorite.book_id} です  "
    if favorite.save
      puts "いいね成功しました"
    else
      puts "失敗‼!!! いいね 失敗しました......"
    end
    # 直前のページにリダイレクト
    # books#index books#show user#show のいずれかを想定
    redirect_to request.referer
  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    puts "消したいfavoriteのデータ... #{favorite} です "
    if favorite.destroy
      puts "いいねの破壊に成功しました"
    else
      puts "失敗‼!!! いいね 失敗しました......"
    end
    # 直前のページにリダイレクト
    # books#index books#show user#show のいずれかを想定
    redirect_to request.referer
  end

end
