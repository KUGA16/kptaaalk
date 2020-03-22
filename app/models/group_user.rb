class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :user
  #booleanのバリデーション
  validates :is_confirmed, inclusion: { in: [true, false] }

end
