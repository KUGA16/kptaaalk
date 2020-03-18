class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many   :rights, dependent: :destroy #commnetが消えるとrightも消える

  validates :comment,
    presence: true #テキスト:空白禁止

  enum place_status: {keep:0, problem:1, try:2}

  # それなボタンにログインユーザーが存在するか
  def righted_by?(user)
    rights.where(user_id: user.id).exists?
  end

  def self.get_right_ranking(group_id, place_status)
    comments = Comment.where(group_id: group_id, place_status: place_status)
    comment_righted_count = comments.joins(:rights).group(:comment_id).count
    comment_righted_ids = Hash[comment_righted_count.sort_by{ |_, v| -v }].keys
    comment_ranking = []
    comment_righted_ids.each do | id |
      comment_ranking << Comment.find(id)
    end
    comments_ids = comments.pluck(:id)
    no_rights_ids = comments_ids - comment_righted_ids
    no_rights_ids.each do | id |
      comment_ranking << Comment.find(id)
    end
    return comments, comment_ranking
  end

end
