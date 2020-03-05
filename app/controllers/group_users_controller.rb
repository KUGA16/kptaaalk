class GroupUsersController < ApplicationController

  before_action :authenticate_user!

  def new
    @group_user_new = GroupUser.new
    @group = Group.find(params[:group_id])
    follower_ids = current_user.followings.pluck(:id) #フォローしているユーザーを配列で取得
    #params[:group_id]と同じgroup_idのGroupUserのuser_idを配列かつint型で取得
    group_user_ids = GroupUser.where(group_id: params[:group_id]).pluck(:user_id).map!(&:to_i)
    invite_user_ids = follower_ids - group_user_ids #差分を取得
    @can_invite_users = User.find(invite_user_ids) #差分user_idを持つuserの情報を取得
    # チェックした瞬間にユーザー表示
    # @join_users = GroupUser.where(group_id: params[:group_id])
  end

  def create
    group = Group.find(params[:group_id])
    if params[:group_user].blank? #ユーザーを未選択でsubmitした時
      redirect_to new_group_group_users_path(group)
      return
    end
    begin #通常時
      params_group_user_ids[:user_id].each do |id|
        GroupUser.create!(user_id: id, group_id: group.id)
      end
    rescue => e #エラー時
      redirect_to new_group_group_users_path(group)
      return
    end
      redirect_to group_comments_path(group), notice: "KPTを作成しました！"
  end

  def update
    join_group = GroupUser.find_by(group_id: params[:group_id], user_id: current_user)
    if join_group.update(is_confirmed: true)
      flash[:notice] = "「#{join_group.group.name}」に参加しました！"
      redirect_to user_path(current_user)
    else
      flash[:notice] = "「#{join_group.group.name}」に参加できませんでした！"
      redirect_to user_path(current_user)
    end
  end

  def destroy
    no_join_group = GroupUser.find_by(group_id: params[:group_id], user_id: current_user)
    no_join_group.destroy
    redirect_to user_path(current_user)
  end


  private

  def params_group_user_ids
    params.require(:group_user).permit(user_id: [])
  end

end
