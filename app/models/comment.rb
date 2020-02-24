class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :comment, presence: true #テキスト:空白禁止
end
