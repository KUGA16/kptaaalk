class CommentsController < ApplicationController
  def index
    # @comment_new = Comment.new
    @group = Group.find(params[:group_id])
    #このグループに参加しているユーザー
    @group_users = GroupUser.where(group_id: prams[:group_id]).where(is_confirmed: true)
    # (is_confirmed: true)
    #userモデルからgroup_userモデルのis_confirmedがtrueのユーザーのみ抽出

  end

  def new
  end

  def create
    @comment_new = Comment.new(comment_params)
    if @comment_new.save!

    else

    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment,:place_status)
  end
end
