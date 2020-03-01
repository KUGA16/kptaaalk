class ApplicationController < ActionController::Base
  #deviseのコントローラを修正
  #devise利用の機能（ユーザ登録、ログイン認証など）の前に実行
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :is_notification

  def after_sign_in_path_for(resource) #ログイン後の画面遷移
    user_path(current_user)
  end

  def after_sign_out_path_for(resource) #ログアウト後の画面遷移
    root_path
  end

  def is_notification
    if current_user.present?
      @is_notification = GroupUser.where(user_id: current_user.id).where(is_confirmed: false)
    end
  end

  #他のコントローラからも参照可能
  protected
  #sign_up,sign_in,account_updateの際に、keyのデータ操作を許可
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email,:name, :nick_name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:nick_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nick_name])
  end
end
