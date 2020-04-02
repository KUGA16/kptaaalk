class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    following_user = current_user.active_relationships.build(follower_id: @user.id)
    following_user.save
    render 'follow'
  end

  def destroy
    @user = User.find(params[:user_id])
    follower_user = current_user.active_relationships.find_by(follower_id: @user.id)
    follower_user.destroy
    render 'follow'
  end
end
