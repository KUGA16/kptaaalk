class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :only_group_user, only: [:index, :new, :create, :destroy]

  def index
    #参加しているユーザー
    @join_users = GroupUser.where(group_id: @group.id).where(is_confirmed: true)
    #招待しているユーザー
    @invit_users = GroupUser.where(group_id: @group.id).where(is_confirmed: false)
    # place_statusでKPTを分けて取得
    @keep_comment_ranking = Comment.get_right_ranking(params[:group_id], "keep")
    @problem_comment_ranking = Comment.get_right_ranking(params[:group_id], "problem")
    @try_comment_ranking = Comment.get_right_ranking(params[:group_id], "try")
    # jsにidを送る為のform用
    @comment_new = Comment.new
  end

  def new
    @comment = Comment.new
    @action = 'create'
    render 'new_modal'
  end

  def create
    @keep_comment_ranking = Comment.get_right_ranking(params[:group_id], "keep")
    @problem_comment_ranking = Comment.get_right_ranking(params[:group_id], "problem")
    @try_comment_ranking = Comment.get_right_ranking(params[:group_id], "try")
    # hidden_fieldでuser_idとgroup_idを取得
    comment = Comment.new(params_post_comment_id)
    if comment.save
      if params_post_comment_id[:place_status] == "keep"
        @keep_comment_ranking << Comment.find(comment.id)
      end
      if params_post_comment_id[:place_status] == "problem"
        @problem_comment_ranking << Comment.find(comment.id)
      end
      if params_post_comment_id[:place_status] == "try"
        @try_comment_ranking << Comment.find(comment.id)
      end
      @status = 'success'
    else
      @status = 'fail'
    end
    render 'change_modal'
  end

  def edit
    @action = 'update'
    render 'new_modal'
  end

  def update
    if @comment.update(params_post_comment_id)
      @keep_comment_ranking = Comment.get_right_ranking(params[:group_id], "keep")
      @problem_comment_ranking = Comment.get_right_ranking(params[:group_id], "problem")
      @try_comment_ranking = Comment.get_right_ranking(params[:group_id], "try")
      @status = 'success'
    else
      @status = 'fail'
    end
    render 'change_modal'
  end

  def destroy
    @comment.destroy
    redirect_to group_comments_path, notice: "投稿を削除しました"
  end

  def place_status_update
    update_comment = Comment.find(params[:comment][:id])
    if update_comment.place_status == update_status_params[:place_status]
      return
    end
      update_comment.update(
        id: update_comment.id,
        user_id: update_comment.user_id,
        group_id: update_comment.group_id,
        comment: update_comment.comment,
        place_status: update_status_params[:place_status]
      )
      user = User.find(update_comment.user_id)
      right = Comment.find(update_comment.id).rights.count
      render json: {
        'place_status': update_status_params[:place_status]
      }
  end

  private

  def params_post_comment_id
    params.require(:comment).permit(:group_id, :comment, :place_status, :user_id)
  end

  def update_status_params
     params.require(:comment).permit(:id, :place_status, :group_id)
  end

end
