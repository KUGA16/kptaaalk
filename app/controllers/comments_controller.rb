class CommentsController < ApplicationController

  before_action :authenticate_user!

  def index
    @group = Group.find(params_group_id)
    #このグループに参加しているユーザー
    @group_users = GroupUser.where(group_id: params_group_id).where(is_confirmed: true)
    # place_statusでKPTを分けて取得
    @keep_comments = Comment.where(group_id: params_group_id, place_status: "keep")
    @probrem_comments = Comment.where(group_id: params_group_id, place_status: "probrem")
    @try_comments = Comment.where(group_id: params_group_id, place_status: "try")
  end

  def new
    @comment_new = Comment.new
    @group = Group.find(params_group_id)
  end

  def create
    @keep_comments = Comment.where(group_id: params_group_id, place_status: "keep")
    @probrem_comments = Comment.where(group_id: params_group_id, place_status: "probrem")
    @try_comments = Comment.where(group_id: params_group_id, place_status: "try")
    @comment_new = Comment.new(
      user_id: current_user.id,
      group_id: params_post_comment_ids[:group_id],
      comment: params_post_comment_ids[:comment],
      place_status: params_post_comment_ids[:place_status]
    )
    respond_to do |format|
      if  @comment_new.save
          format.html { redirect_to @comment_new, notice: 'User was successfully created.' }
          format.json { render :new, status: :created, location: @comment_new }
          format.js { @status = 'success' }
      else
          format.html { render :new }
          format.json { render json: @comment_new.errors, status: :unprocessable_entity }
          format.js { @status = 'fail' }
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to group_comments_path, notice: "投稿を削除しました"
  end

  private

  def params_post_comment_ids
    params.require(:comment).permit(:group_id, :comment, :place_status)
  end

  def params_group_id
    params.require(:group_id)
  end
end
