class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :comment, presence: true #テキスト:空白禁止
  enum place_status: {keep:0, probrem:1, try:2,
stock:3}
end
