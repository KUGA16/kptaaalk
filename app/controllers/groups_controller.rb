class GroupsController < ApplicationController

  before_action :authenticate_user!
  before_action :barrier_group, only: [:show, :edit, :update, :destroy]

  def show
    @group = Group.find(params[:id])
    @group_users = GroupUser.where(group_id: @group.id).where(is_confirmed: true)
    @inviting_users = GroupUser.where(group_id: @group.id).where(is_confirmed: false)
  end

  def new
    @group_new = Group.new
  end

  def create
    @group_new = Group.new(group_params)
    # グループ作成者をgroup_usersテーブルに登録
    if @group_new.save
      GroupUser.create(
        user_id: current_user.id,
        group_id: @group_new.id,
        is_confirmed: true
      )
      redirect_to new_group_group_users_path(@group_new), notice: "「#{@group_new.name}」を作成しました！"
    else
      render 'new'
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group), notice: "グループのプロフィールを変更しました！"
    else
      render 'edit'
    end
  end

  def destroy
    group = Group.find(params[:id])
  	group.destroy
  	redirect_to user_path(current_user), notice: "#{group.name}を削除しました"
  end

  private

  def group_params
    params.require(:group).permit(:name, :group_image)
  end

  #url直接入力禁止
  def barrier_group
    group_users = GroupUser.where(group_id: params[:id]).where(user_id: current_user.id).where(is_confirmed: true).pluck(:user_id)
    unless group_users.include?(current_user.id)
      redirect_to user_path(current_user)
    end
  end

end
