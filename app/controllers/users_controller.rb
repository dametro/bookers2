class UsersController < ApplicationController
  def index
    #一覧表示
    @users = User.all
    #左上プロフィール用
    @your_user = current_user

    #投稿フォーム:render new_book用
    @new_book = Book.new
  end

  def show
    #左上、あなたのみではなく、任意の注目ユーザー
    @user = User.find(params[:id])
    #その人の投稿したbook
    # @books = Book.where(user_id: @user.id)
    @books = @user.books #でよい(modelで定義)  #教材
    
    #投稿フォーム:render new_book用
    @new_book = Book.new

  end

  def edit
  end
end
