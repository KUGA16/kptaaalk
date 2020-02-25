class Member < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates :is_confirmed, inclusion: { in: [true, false] } #booleanのバリデーション
end
