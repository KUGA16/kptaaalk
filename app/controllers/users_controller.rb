class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :baria_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @join_groups = GroupUser.where(user_id: current_user.id).where(is_confirmed: true)
    @invited_groups = GroupUser.where(user_id: current_user.id).where(is_confirmed: false)
# (qurey)検索フォームで入力された値をパラメータで取得
    # @q = User.ransack(params[:q])
    # if params[:q] == nil || params[:q][:nick_name_cont] == ""
    #   @search_users = []
    #   return
    # end
# 空検索しないようにするため
# @search_usersの配列からcurrent_user要素は取り除く
    # @search_users = @q.result(distinct: true).where.not(id: current_user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: "プロフィールを変更しました！"
    else
      render 'edit'
    end
  end

  def destroy
  end

  def result
# (qurey)検索フォームで入力された値をパラメータで取得
    @q = User.ransack(params[:q])
    if params[:q] == nil || params[:q][:nick_name_cont] == ""
      @search_users = []
      return
    end
# 空検索しないようにするため
# @search_usersの配列からcurrent_user要素は取り除く
    @search_users = @q.result(distinct: true).where.not(id: current_user.id)
  end

  def friends
    @user = User.find(params[:user_id])
    @following_users = @user.followings
    @follower_users = @user.followers
  end


  private

  def user_params
    params.require(:user).permit(:name, :nick_name, :introduction, :profile_image)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
  def baria_user
       user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end

end
