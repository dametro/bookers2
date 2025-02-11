class UsersController < ApplicationController
  def index
    #一覧表示
    @users = User.all
    #左上プロフィール用
    @your_user = current_user
  end

  def show
  end

  def edit
  end
end
