class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :comment, presence: true #テキスト:空白禁止
  enum place_status: {k:0, p:1, t:2, s:3}
end
