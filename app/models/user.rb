class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :group_users, dependent: :destroy #userが消えるとgroup_userも消える
  has_many :groups, through: :group_users
  has_many :comments,    dependent: :destroy #userが消えるとcommentも消える
  has_many :rights,      dependent: :destroy #userが消えるとrightも消える

  # ====================自分がフォローしているユーザーとの関連 ===================================
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower
  # ========================================================================================
  # ====================自分がフォローされるユーザーとの関連 ===================================
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following
  # =======================================================================================

  attachment :profile_image #refileが指定のカラムにアクセスするために必要

  validates :nick_name, presence: true, uniqueness: true #ニックネーム:空白禁止、一意である

  def followed_by?(user)
    # フォローしようとしているユーザーがフォローされているユーザーの中から、自分がいるかどうかを調べる
    passive_relationships.find_by(following_id: user.id).present?
  end

end
