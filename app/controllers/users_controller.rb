class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :params_user_id

  def show
    @user = User.find(params_user_id)
    @join_groups = GroupUser.where(user_id: current_user.id).where(is_confirmed: true)
    @follow_users = @user.followings
  end

  def edit
    @user = User.find(params_user_id)
  end

  def update
    @user = User.find(params_user_id)
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

  def params_user_id
    params.require(:id)
  end

  def user_params
    params.require(:user).permit(:name, :nick_name, :introduction, :profile_image)
  end
end
