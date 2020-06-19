class SearchController < ApplicationController

  before_action :authenticate_user!

  def users
    # (qurey)検索フォームで入力された値をパラメータで取得
    @q = User.ransack(params[:q])
    if params[:q] == nil || params[:q][:nick_name_cont] == ""
      @search_users = []
      return
    end
    @search_users = @q.result(distinct: true).where.not(id: current_user.id)
  end

  def groups
    @user = current_user
    @joined_groups = []
    @invited_groups = []
    @q = Group.ransack(params[:q])
    groups = @q.result(distinct: true)
    # groupsは当てハマるDB全てのgroup
    groups.each do |group|
      group.group_users.each do |group_user|
        # group_user.user_idがcurrent_userであることと
        if group_user.user_id == current_user.id
          # is_confirmedが参加、招待中によって変数を変更
          case group_user.is_confirmed
          when true
            @joined_groups << group_user
          when false
            @invited_groups << group_user
          end
        end
        # group_user.user_idがcurrent_userでない時は[]で返す
      end
    end
    group_count = (@joined_groups + @invited_groups).count
    flash[:notice] = "検索結果：#{group_count}件"
    render "users/show"
  end

end
