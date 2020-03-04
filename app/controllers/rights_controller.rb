class RightsController < ApplicationController
  def create
    comment = Comment.find(params[:comment_id])
    right = current_user.rights.new(comment_id: comment.id, group_id: params[:group_id])
    binding.pry
    right.save
    redirect_to group_comments_path
  end

  def destroy
    comment = Comment.find(params[:comment_id])
    right = current_user.rights.find_by(comment_id: comment.id, group_id: params[:group_id])
    right.destroy
    redirect_to group_comments_path
  end
end
