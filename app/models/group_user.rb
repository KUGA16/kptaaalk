class GroupUser < ApplicationRecord
  #booleanのバリデーション
  validates :is_confirmed, inclusion: { in: [true, false] }

  belongs_to :group
  belongs_to :user
end
]
