class GroupsController < ApplicationController

  def show
  end

  def new
    @group_new = Group.new
  end

  def create
    # @group_new = Group.new(group_params)
    # @group_new.save

  end

  def edit
  end

  def destroy
  end

  # private
  # def group_params
  #   params.require(:group).permit(:name, :group_image)
  # end

end
