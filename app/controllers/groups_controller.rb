class GroupsController < ApplicationController

  before_action :authenticate_user!
  before_action :only_group_user, only: [:edit, :update, :destroy]

  def show
    @join_users = GroupUser.where(group_id: @group.id).where(is_confirmed: true)
    @invit_users = GroupUser.where(group_id: @group.id).where(is_confirmed: false)
    @join_user = @join_users.any? {|group| group.user_id == current_user.id}
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    # グループ作成者をgroup_usersテーブルに登録
    if @group.save
      GroupUser.create(
        user_id: current_user.id,
        group_id: @group.id,
        is_confirmed: true
      )
      flash[:notice] = "「#{@group.name}」を作成しました。"
      redirect_to new_group_group_users_path(@group)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      flash[:notice] = "グループのプロフィールを変更しました。"
      redirect_to group_path(@group)
    else
      render 'edit'
    end
  end

  def destroy
  	@group.destroy
    flash[:notice] = "#{@group.name}を削除しました。"
  	redirect_to user_path(current_user)
  end

  private

  def group_params
    params.require(:group).permit(:name, :group_image)
  end

end
