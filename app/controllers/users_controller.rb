class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :barrier_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @joined_groups = GroupUser.where(user_id: @user.id, is_confirmed: true).page(params[:page])
    @invited_groups = GroupUser.where(user_id: @user.id, is_confirmed: false).page(params[:page])
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

  def friends
    @user = User.find(params[:user_id])
    @following_users = @user.followings.page(params[:following_user])
    @follower_users = @user.followers.page(params[:follower_user])
  end

  private

  def user_params
    params.require(:user).permit(:name, :nick_name, :introduction, :profile_image)
  end

  #url直接入力禁止
  def barrier_user
       user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end

end
