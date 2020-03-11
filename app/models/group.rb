class Group < ApplicationRecord
  has_many :users, through: :group_users
  has_many :group_users, dependent: :destroy #groupが消えるとgroup_userも消える
  has_many :comments,    dependent: :destroy #groupが消えるとgroup_userも消える
  has_many :rights,       dependent: :destroy #groupが消えるとrightも消える

  attachment :group_image#画像を挿入するため
  #グループ名:空白禁止、一意であること、1文字以上20文字以内
  validates :name,
    presence: true,
    uniqueness: true,
    length: { in: 1..20 }

end
