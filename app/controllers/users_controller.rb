class UsersController < ApplicationController
  def index
    @user = current_user #右上プロフィール用
  end

  def show
  end

  def edit
  end
end
