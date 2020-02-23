class Group < ApplicationRecord
  #グループ名:空白禁止、1文字以上20文字以内
  validates :name,presence: true,length: { in: 1..20 }
  #画像を挿入するため
  attachment :group_image
  #groupが消えるとgroup_userも消える
  has_many :group_users, dependent: :destroy
end
