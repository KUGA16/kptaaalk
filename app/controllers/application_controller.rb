class ApplicationController < ActionController::Base
  #deviseのコントローラを修正
  #devise利用の機能（ユーザ登録、ログイン認証など）の前に実行
  before_action :configure_permitted_parameters, if: :devise_controller?

  #他のコントローラからも参照可能
  protected
  #sign_up,sign_in,account_updateの際に、keyのデータ操作を許可
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email,:name, :nick_name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:nick_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nick_name])
  end
end
