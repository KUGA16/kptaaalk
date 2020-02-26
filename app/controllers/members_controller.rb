class MembersController < ApplicationController

  def new
    #ログインユーザー以外のユーザー
    @users = User.where.not(id: current_user.id)
    @group = Group.find(params[:group_id])
    @member_new = Member.new
  end

  def create
    # member_new = Member.new(member_params)
    params[:member][:user_id].each do |id|
      if Member.create!(user_id: id, group_id:  params[:group_id])
         # redirect_to group_comments_path(@member_new)
         redirect_to '/'
      else
      # render 'new'
      end
    end
  end

  private

  def member_params
    params.require(:member).permit(:is_confirmed)
  end

end
