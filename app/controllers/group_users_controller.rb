class GroupUsersController < ApplicationController

  before_action :authenticate_user!

  def new
    @follower_ids = current_user.followings.pluck(:id) #ログインユーザーのフォローしているユーザー
    #params[:group_id]と同じgroup_idのGroupUserのuser_idを配列かつint型で取得
    @group_user_ids = GroupUser.where(group_id: params[:group_id]).pluck(:user_id).map!(&:to_i)
    @invite_user_ids = @follower_ids - @group_user_ids #差分を取得
    @can_invite_users = User.find(@invite_user_ids) #差分user_idを持つuserの情報を取得
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
