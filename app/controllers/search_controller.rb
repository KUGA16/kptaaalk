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

end
