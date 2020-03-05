class GroupsController < ApplicationController

  before_action :authenticate_user!

  def show
    @group = Group.find(params[:id])
    @group_users = GroupUser.where(group_id: params[:id]).where(is_confirmed: true)
  end

  def new
    @group_new = Group.new
  end

  def create
    if @group_new = Group.create!(group_params)
        GroupUser.create!(
          user_id: current_user.id,
          group_id: @group_new.id,
          is_confirmed: true
        )
        redirect_to new_group_group_users_path(@group_new), notice: "「#{@group_new.name}」グループを作成しました！"
    else
        render 'new'
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if  @group.update(group_params)
        redirect_to group_path(@group), notice: "グループのプロフィールを変更しました！"
    else
        render 'edit'
    end
  end

  def destroy
  end


  private

  def group_params
    params.require(:group).permit(:name, :group_image)
  end

end
