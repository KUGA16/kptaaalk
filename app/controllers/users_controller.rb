class UsersController < ApplicationController

  before_action :user_find, only: [:show,:edit,:update]

  def show
    @group_users = GroupUser.where(user_id: current_user.id)
  end

  def edit
  end

  def update
    if  @user.update(user_params)
        redirect_to @user, notice: "プロフィールを変更しました！"
    else
        render 'edit'
    end
  end

  def destroy
  end

  def result
    @search = User.ransack(params[:q]) # (qurey)検索フォームで入力された値をパラメータで取得
    @search_users = @search.result(distinct: true) # 空検索しないようにするため
  end


  private

  def user_find
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :nick_name, :introduction, :profile_image)
  end
end
