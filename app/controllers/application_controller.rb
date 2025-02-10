class ApplicationController < ActionController::Base

  # 初期状態の devise は、サインアップ、サインイン時に「email」と「パスワード」
  # しか受け取ることを許可されていません。deviseのコントローラは直接修正
  # できないため、全てのコントローラに対する処理を行える権限を持つ、
  # ApplicationControllerに記述する必要があります。
  # 
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
  # ここがnameのままだと、sign_up時は、 入力したemailが抹消?され、
  # Email can't be blank が出る


end
