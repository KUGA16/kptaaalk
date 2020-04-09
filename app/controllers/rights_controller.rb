class RightsController < ApplicationController
  def create
    right = current_user.rights.new(comment_id: @comment.id, group_id: params[:group_id])
    right.save
    render 'right'
  end

  def destroy
    right = current_user.rights.find_by(comment_id: @comment.id, group_id: params[:group_id])
    right.destroy
    render 'right'
  end
end
