class ApplicationController < ActionController::Base
  #deviseのコントローラを修正
  #devise利用の機能（ユーザ登録、ログイン認証など）の前に実行
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :is_notification
  #ログイン後の画面遷移
  def after_sign_in_path_for(resource)
    result_users_path
  end
  #ログアウト後の画面遷移
  def after_sign_out_path_for(resource)
    root_path
  end
  #ログインユーザーがグループに招待されているか
  def is_notification
    if user_signed_in?
      @is_notification = GroupUser.is_notification?(current_user)
    end
  end

  #他のコントローラからも参照可能
  protected
  #sign_up,sign_in,account_updateの際に、keyのデータを許可
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email,:name, :nick_name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:nick_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nick_name])
  end
end
