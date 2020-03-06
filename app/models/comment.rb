class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many   :rights, dependent: :destroy #commnetが消えるとrightも消える

  validates :comment, presence: true #テキスト:空白禁止
  enum place_status: {keep:0, probrem:1, try:2, stock:3}

  # それなボタンにログインユーザーが存在するか
  def righted_by?(user)
    rights.where(user_id: user.id).exists?
  end
end
