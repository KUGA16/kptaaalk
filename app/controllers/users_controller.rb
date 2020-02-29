class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @group_users = GroupUser.where(user_id: current_user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user = User.find(params[:id])
       @user.update(user_params)
       redirect_to @user, notice: "プロフィールを変更しました！"
    else
       render 'edit'
    end
  end

  def destroy
  end

  def result
  end

  private
  def user_params
    params.require(:user).permit(:name, :nick_name, :introduction, :profile_image)
  end
end
