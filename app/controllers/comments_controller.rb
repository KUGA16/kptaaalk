class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :barrier_comment, except: [:place_status_update]

  def index
    @group = Group.find(params[:group_id])
#参加しているユーザー
    @group_users = GroupUser.where(group_id: @group.id).where(is_confirmed: true)
#招待しているユーザー
    @inviting_users = GroupUser.where(group_id: @group.id).where(is_confirmed: false)
    # place_statusでKPTを分けて取得
    @keep_comments, @keep_comment_ranking = Comment.get_right_ranking(params[:group_id], "keep")


    @probrem_comments, @probrem_comment_ranking = Comment.get_right_ranking(params[:group_id], "probrem")
    # @probrem_comments = Comment.where(group_id: params[:group_id], place_status: "probrem")
    # comment_righted_count = @probrem_comments.joins(:rights).group(:comment_id).count
    # comment_righted_ids = Hash[comment_righted_count.sort_by{ |_, v| -v }].keys
    # @probrem_comment_ranking = []
    # comment_righted_ids.each do | id |
    #   @probrem_comment_ranking << Comment.find(id)
    # end

    @try_comments, @try_comment_ranking = Comment.get_right_ranking(params[:group_id], "try")
    # @try_comments = Comment.where(group_id: params[:group_id], place_status: "try")
    # comment_righted_count = @try_comments.joins(:rights).group(:comment_id).count
    # comment_righted_ids = Hash[comment_righted_count.sort_by{ |_, v| -v }].keys
    # @try_comment_ranking = []
    # comment_righted_ids.each do | id |
    #   @try_comment_ranking << Comment.find(id)
    # end

    @comment_new = Comment.new
  end

  def new
    @comment_new = Comment.new
    @group = Group.find(params[:group_id])
  end

  def create
    @keep_comments, @keep_comment_ranking = Comment.get_right_ranking(params[:group_id], "keep")

    @probrem_comments, @probrem_comment_ranking = Comment.get_right_ranking(params[:group_id], "probrem")

    @try_comments, @try_comment_ranking = Comment.get_right_ranking(params[:group_id], "try")
    # @keep_comments = Comment.where(group_id: params[:group_id], place_status: "keep")
    # comment_righted_count = @keep_comments.joins(:rights).group(:comment_id).count
    # comment_righted_ids = Hash[comment_righted_count.sort_by{ |_, v| -v }].keys
    # @keep_comment_ranking = []
    # comment_righted_ids.each do | id |
    #   @keep_comment_ranking << Comment.find(id)
    # end
    # comments_ids = @keep_comments.pluck(:id)
    # no_rights_ids = comments_ids - comment_righted_ids
    # no_rights_ids.each do | id |
    #   @keep_comment_ranking << Comment.find(id)
    # end
    #
    # @probrem_comments = Comment.where(group_id: params[:group_id], place_status: "probrem")
    # comment_righted_count = @probrem_comments.joins(:rights).group(:comment_id).count
    # comment_righted_ids = Hash[comment_righted_count.sort_by{ |_, v| -v }].keys
    # @probrem_comment_ranking = []
    # comment_righted_ids.each do | id |
    #   @probrem_comment_ranking << Comment.find(id)
    # end
    #
    # @try_comments = Comment.where(group_id: params[:group_id], place_status: "try")
    # comment_righted_count = @try_comments.joins(:rights).group(:comment_id).count
    # comment_righted_ids = Hash[comment_righted_count.sort_by{ |_, v| -v }].keys
    # @try_comment_ranking = []
    # comment_righted_ids.each do | id |
    #   @try_comment_ranking << Comment.find(id)
    # end
    # hidden_fieldでuser_idとgroup_idを取得
    @comment_new = Comment.new(params_post_comment_id)
    respond_to do |format|
      if  @comment_new.save
          if params_post_comment_id[:place_status] == "keep"
            @keep_comment_ranking << Comment.find(@comment_new.id)
          end
          if params_post_comment_id[:place_status] == "probrem"
            @probrem_comment_ranking << Comment.find(@comment_new.id)
          end
          if params_post_comment_id[:place_status] == "try"
            @try_comment_ranking << Comment.find(@comment_new.id)
          end
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
    update_comment = Comment.find(params[:comment][:id])
    if update_comment.place_status == update_status_params[:place_status]
      return {"hoge":"hoge"}
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
        'id': update_comment.id,
        'user_id': update_comment.user_id,
        'nick_name': user.nick_name,
        'comment': update_comment.comment,
        'group_id': update_comment.group_id,
        'user_image': user.profile_image,
        'place_status': update_status_params[:place_status],
        'right': right
      }
  end


  private

  def params_post_comment_id
    params.require(:comment).permit(:group_id, :comment, :place_status, :user_id)
  end

  def update_status_params
     params.require(:comment).permit(:id, :place_status)
  end

  def status_params
    params.require(:comment).permit(:id, :place_status)
  end

#url直接入力禁止
  def barrier_comment
    group_users = GroupUser.where(group_id: params[:group_id]).where(user_id: current_user.id).where(is_confirmed: true).pluck(:user_id)
    unless group_users.include?(current_user.id)
      redirect_to user_path(current_user)
    end
  end

end
