class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #devise利用の機能（ユーザ登録、ログイン認証など）の前に実行
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :is_notification
  before_action :set_user
  before_action :set_group
  before_action :set_comment

  #ログイン後の画面遷移
  def after_sign_in_path_for(resource)
    user_path(current_user)
  end
  #ログアウト後の画面遷移
  def after_sign_out_path_for(resource)
    root_path
  end

  private

  def set_user
    @user = User.find(params[:user_id]) if params[:user_id].present?
  end

  def set_group
    @group = Group.find(params[:group_id]) if params[:group_id].present?
  end

  def set_comment
    @comment = Comment.find(params[:comment_id]) if params[:comment_id].present?
  end

  #ログインユーザーがグループに招待されているか
  def is_notification
   if user_signed_in?
      @is_notification = GroupUser.where(user_id: current_user.id).where(is_confirmed: false)
   end
  end

  #url直接入力禁止
  def only_group_user
    unless GroupUser.where(group_id: @group.id, is_confirmed: true).any? {|group| group.user_id == current_user.id}
       redirect_to user_path(current_user)
    end
  end

  #sign_up,sign_in,account_updateの際に、keyのデータを許可
  def configure_permitted_parameters
    added_attrs = [:nick_name]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end
end
