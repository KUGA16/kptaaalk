class CommentsController < ApplicationController
  def index
    # @comment_new = Comment.new
    @group = Group.find(params[:group_id])
    #このグループに参加しているユーザー
    @group_users = GroupUser.where(group_id: params[:group_id]).where(is_confirmed: true)
    #このグループのみのコメント
    @comments = Comment.where(group_id: params[:group_id])
  end

  def new
    @comment_new = Comment.new
    @group = Group.find(params[:group_id])
  end

  def create
    @comments = Comment.where(group_id: params[:group_id])
    @comment_new = Comment.new(
      user_id: current_user.id,
      group_id: params[:group_id],
      comment: params[:comment][:comment],
      place_status: params[:place_status]
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
  end

  private

  def comment_params
    params.permit(:comment,:place_status)
  end
end
