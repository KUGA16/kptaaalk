class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :user_find, only: [:show,:edit,:update]

  def show
    @group_users = GroupUser.where(user_id: current_user.id)
    @follow_users = @user.followings
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

  def result
    @q = User.ransack(params[:q]) # (qurey)検索フォームで入力された値をパラメータで取得
    if params[:q] == nil || params[:q][:nick_name_cont] == ""
      @search_users = []
      return
    end
    @search_users = @q.result(distinct: true).where.not(id: current_user.id) # 空検索しないようにするため
    # @search_usersの配列から、idがcurrent_user.id と同じ要素は取り除く
  end


  private

  def user_find
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :nick_name, :introduction, :profile_image)
  end
end
