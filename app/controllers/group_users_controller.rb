class GroupUsersController < ApplicationController

  def new
    #ログインユーザー以外のユーザー
    @users = User.where.not(id: current_user.id)
    @group = Group.find(params[:id])
    @group_user_new = GroupUser.new
  end

  def create
    if @group_user_new = GroupUser.new(group_users_params)
       # @group_user_new.user_id = current_user.id
       # @group_user_new.grop_id = #自分が作ったグループ
       # @group_user_new.is_confirmed =
       # @group_user_new.save!
       # redirect_to comments_path
    else
      # render 'new'
    end
  end

end
