class RightsController < ApplicationController
  def create
    @comment = Comment.find(params[:comment_id])
    right = current_user.rights.new(comment_id: @comment.id, group_id: params[:group_id])
    right.save
    # create.js.erbを探しに行く
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    right = current_user.rights.find_by(comment_id: @comment.id, group_id: params[:group_id])
    right.destroy
    # destroy.js.erbを探しに行く
  end
end
