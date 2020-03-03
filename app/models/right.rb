class Right < ApplicationRecord
  belongs_to :user
  belongs_to :group
  belongs_to :comment

  # ログインユーザーがそれなボタンを押しているか
  def righted_by?(user)
    rights.where(user_id: user.id).exit?
  end
end
