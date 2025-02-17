class FavoritesController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    favorite.save
    puts "いいね成功しました"
    # 直前のページにリダイレクト
    # books#index books#show user#show のいずれかを想定
    redirect_to request.referer
  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
    puts "失敗‼!!! いいね 失敗しました......"
    # 直前のページにリダイレクト
    # books#index books#show user#show のいずれかを想定
    redirect_to request.referer
  end

end
