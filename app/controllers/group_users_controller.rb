class GroupUsersController < ApplicationController

  before_action :authenticate_user!
  before_action :only_group_user, only: [:new, :create]

  def new
    @group_user_new = GroupUser.new
    @group = Group.find(params[:group_id])
    #フォローしているユーザーを配列で取得
    follower_ids = current_user.followings.pluck(:id)
    #params[:group_id]と同じidのuserを配列かつint型で取得
    group_user_ids = GroupUser.where(group_id: @group.id).pluck(:user_id).map!(&:to_i)
    invite_user_ids = follower_ids - group_user_ids #差分を取得
    @can_invite_users = User.find(invite_user_ids)
  end

  def create
    group = Group.find(params[:group_id])
    if params[:group_user].blank? #ユーザーを未選択でsubmitした時
      flash[:notice] = "招待するお仲間を選択してください。"
      redirect_to new_group_group_users_path(group)
      return
    end
    GroupUser.transaction do
      params_group_user_ids[:user_id].each do |id|
        GroupUser.create!(user_id: id, group_id: group.id)
      end
    end
      flash[:notice] = "KPTを作成しました。"
      redirect_to group_comments_path(group)
    rescue
      flash[:notice] = "エラーが発生しました。"
      redirect_to new_group_group_users_path(group)
  end

  def update
    join_group = current_user.group_users.find_by(group_id: params[:group_id])
    if join_group.update(is_confirmed: true)
      flash[:notice] = "「#{join_group.group.name}」に参加しました。"
      redirect_to group_comments_path(join_group.group.id)
    else
      flash[:notice] = "「#{join_group.group.name}」に参加できませんでした。"
      redirect_to user_path(current_user)
    end
  end

  def destroy
    no_join_group = current_user.group_users.find_by(group_id: params[:group_id])
    no_join_group.destroy
    flash[:notice] = "「#{no_join_group.group.name}」を退会しました。"
    redirect_to user_path(current_user)
  end

  private

  def params_group_user_ids
    params.require(:group_user).permit(user_id: [])
  end

end
