class GroupsController < ApplicationController

  def show
  end

  def new
    @group_new = Group.new
  end

  def create
    if @group_new = Group.create(group_params)
       @member = Member.new(
          user_id: current_user.id,
          group_id: @group_new.id,
          is_confirmed: true
         )
         @member.save
       redirect_to new_group_members_path(@group_new)
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
