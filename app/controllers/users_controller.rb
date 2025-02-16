class UsersController < ApplicationController
  #他人のプロフィールを編集させない！
  before_action :is_matching_login_user, only: [:edit, :update]

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
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      puts "成功！userプロフィール update."
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else 
      puts "失敗...... 。userプロフィール updateできず."
      render :edit
    end
      
  end

  # ユーザーデータのストロングパラメータ
  private

  #許容(not必須)カラム名
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
    #他人のプロフィールを編集させないよう、自分の編集画面に飛ばす
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user) #.idじゃなくていいんだっけ
    end
  end

end
