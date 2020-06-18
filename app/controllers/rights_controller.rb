class RightsController < ApplicationController
  def create
    current_user.rights.create(comment_id: @comment.id, group_id: params[:group_id])
    render 'right'
  end

  def destroy
    right = current_user.rights.find_by(comment_id: @comment.id, group_id: params[:group_id])
    right.destroy
    render 'right'
  end
end
