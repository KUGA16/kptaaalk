class CommentsController < ApplicationController

  before_action :authenticate_user!

  def index
    @group = Group.find(params[:group_id])
    #このグループに参加しているユーザー
    @group_users = GroupUser.where(group_id: params[:group_id]).where(is_confirmed: true)
    # place_statusでKPTを分けて取得
    @keep_comments = Comment.where(group_id: params[:group_id], place_status: "keep")
    @probrem_comments = Comment.where(group_id: params[:group_id], place_status: "probrem")
    @try_comments = Comment.where(group_id: params[:group_id], place_status: "try")
    @comment_new = Comment.new
  end

  def new
    @comment_new = Comment.new
    @group = Group.find(params[:group_id])
  end

  def create
    @keep_comments = Comment.where(group_id: params[:group_id], place_status: "keep")
    @probrem_comments = Comment.where(group_id: params[:group_id], place_status: "probrem")
    @try_comments = Comment.where(group_id: params[:group_id], place_status: "try")
    # hidden_fieldでuser_idとgroup_idを取得
    @comment_new = Comment.new(params_post_comment_id)
    respond_to do |format|
      if  @comment_new.save
          format.html { redirect_to @comment_new, notice: 'KPTを投稿しました！' }
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

  def place_status_update
    comment = Comment.find(params[:comment][:id])
    comment.update(
      id: comment.id,
      user_id: comment.user_id,
      group_id: comment.group_id,
      comment: comment.comment,
      place_status: update_params[:place_status]
    )
  end


  private

  def params_post_comment_id
    params.require(:comment).permit(:group_id, :comment, :place_status, :user_id)
  end

  def update_params
     params.require(:comment).permit(:id, :place_status)
  end

end
