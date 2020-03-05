class RelationshipsController < ApplicationController
  def create
    @users = current_user.active_relationships.build(follower_id: params[:user_id])
    @users.save
    redirect_back(fallback_location: result_users_path)
  end

  def destroy
    @users = current_user.active_relationships.find_by(follower_id: params[:user_id])
    @users.destroy
    redirect_back(fallback_location: result_users_path)
  end
end
