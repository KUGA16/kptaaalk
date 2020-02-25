class MembersController < ApplicationController

  def new
    #ログインユーザー以外のユーザー
    @users = User.where.not(id: current_user.id)
    @group = Group.find(params[:group_id])
    # @member_new = Member.new
  end

  def create
     @member_new = Member.new(member_params)
    if @member_new.save!

    else
      # render 'new'
    end
  end

  private

  def member_params
    params.require(:member).permit(:is_confirmed)
  end

end
