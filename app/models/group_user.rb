class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :user
  #booleanのバリデーション
  validates :is_confirmed, inclusion: { in: [true, false] }
  # ログインユーザーがグループに招待されているか
  def self.is_notification?(user)
    self.where(user_id: user.id).where(is_confirmed: false)
  end
end
