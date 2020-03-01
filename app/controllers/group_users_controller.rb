class GroupUsersController < ApplicationController

  before_action :authenticate_user!
  before_action :group_find, only: [:new, :create]

  def new
    @follower_ids = current_user.followings.pluck(:id) #フォローしているユーザーを配列で取得
    #params[:group_id]と同じgroup_idのGroupUserのuser_idを配列かつint型で取得
    @group_user_ids = GroupUser.where(group_id: @group.id).pluck(:user_id).map!(&:to_i)
    @invite_user_ids = @follower_ids - @group_user_ids #差分を取得
    @can_invite_users = User.find(@invite_user_ids) #差分user_idを持つuserの情報を取得
    @join_users = GroupUser.where(group_id: @group.id).where(is_confirmed: true)
    @group_user_new = GroupUser.new
  end

  def create

    if params[:group_user].blank? #ユーザーを未選択でsubmitした時
      redirect_to new_group_group_users_path(@group)
      return
    end
    begin #通常時
      params_group_user_ids[:user_id].each do |id|
        GroupUser.create!(user_id: id, group_id: @group.id)
      end
    rescue => e #エラー時
      redirect_to new_group_group_users_path(@group)
      return
    end
      redirect_to group_comments_path(@group)
  end

  private
  def group_find
    @group = Group.find(params[:group_id])
  end

  def params_group_user_ids
    params.require(:group_user).permit(user_id: [])
  end

end
