class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :barrier_user, only: [:edit, :update]

  def show
    @joined_groups = GroupUser.where(user_id: @user.id, is_confirmed: true).page(params[:page])
    @invited_groups = GroupUser.where(user_id: @user.id, is_confirmed: false)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "プロフィールを変更しました！"
    else
      render 'edit'
    end
  end

  def destroy
  end

  def friends
    @following_users = @user.followings.page(params[:following_user])
    @follower_users = @user.followers.page(params[:follower_user])
  end

  private

  def user_params
    params.require(:user).permit(:name, :nick_name, :introduction, :profile_image, :remove_profile_image)
  end

  #url直接入力禁止
  def barrier_user
    unless @user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end

end
