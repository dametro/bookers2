class BookCommentsController < ApplicationController

  def create
    # urlは POST /books/:book_id/book_comments なので、:book_idで取得できるはず
    book = Book.find(params[:book_id])
    # book_comment = current_user.book_comments.new(book_comment_params)
    # フォームから受け取る
    book_comment = BookComment.new(book_comment_params)
    book_comment.book_id = book.id    
    book_comment.user_id = current_user.id 

    puts "新しいbook_commentのデータ... #{book_comment}, id:#{book_comment.id}, user: #{book_comment.user_id}, book: #{book_comment.book_id} です  "
    if book_comment.save
      puts "コメント成功しました"
    else
      puts "失敗‼!!! コメント 失敗しました......"
    end
    # 直前のページにリダイレクト？いままで通りshow限定でもいい
    # books#show  のみを想定
    # redirect_to book_path(book)
    redirect_to request.referer

  end

  def destroy
    # urlは DELETE /books/:book_id/book_comments/:id なので、:idでコメントid取得できるはず
    book_comment = BookComment.find(params[:id])  
    puts "消したいbook_commentのデータ... #{book_comment} です "

    if book_comment.user_id == current_user.id

      puts "あなたは確かにコメント主です、削除を許可します"
      if book_comment.destroy
        puts "コメントの破壊に成功しました"
      else
        puts "失敗‼!!! コメント 失敗しました......"
      end

    else
      puts "不許可！ あなたはコメント主ではありません、削除は許可しません！！"
    end
    
    # 直前のページにリダイレクト？いままで通りshow限定でもいい
    # books#show  のみを想定
    # redirect_to book_path(book)
    redirect_to request.referer
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
