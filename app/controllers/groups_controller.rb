class GroupsController < ApplicationController

  def show
  end

  def new
    @group_new = Group.new
  end

  def create
    @group_new = Group.new(group_params)
    if @group_new.save
       @group_user = GroupUser.new
         @group_user.user_id = current_user.id
         @group_user.group_id = @group_new.id
         @group_user.is_confirmed = true
         @group_user.save
       redirect_to group_user_path(@group_new)
    else
       render 'new'
    end
  end

  def edit
  end

  def destroy
  end

  private
  def group_params
    params.require(:group).permit(:name, :group_image)
  end

end
