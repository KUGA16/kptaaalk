class GroupUsersController < ApplicationController

  before_action :authenticate_user!

  def new
    @users = current_user.followings #ログインユーザーのフォローしているユーザー
    # 送られてきたgroup_idと一致するgroup取得
    #そのグループに入っているユーザーは表示しない（is_confirmedがtrue）
    #is_confirmedがfalseの人は表示する
    @group = Group.find(params[:group_id])
    @group_user_new = GroupUser.new
  end

  def create
    group = Group.find(params[:group_id])
    params[:group_user][:user_id].each do |id|
      if GroupUser.create!(user_id: id, group_id: params[:group_id])
         redirect_to group_comments_path(group)
         return
      end
    end
  end

  private

  def group_user_params
    params.require(:group_user).permit(:is_confirmed)
  end

end
