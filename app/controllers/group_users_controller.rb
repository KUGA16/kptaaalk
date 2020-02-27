class GroupUsersController < ApplicationController

  def new
    #ログインユーザー以外のユーザー
    @users = User.where.not(id: current_user.id)
    @group = Group.find(params[:group_id])
    @group_user_new = GroupUser.new
  end

  def create
    # group_user_new = GroupUser.new(group_user_params)
    params[:group_user][:user_id].each do |id|
      if GroupUser.create!(user_id: id, group_id: params[:group_id])
         redirect_to group_comments_path
      else
      # render 'new'
      end
    end
  end

  private

  def group_user_params
    params.require(:group_user).permit(:is_confirmed)
  end

end
