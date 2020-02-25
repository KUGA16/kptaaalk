class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :members, dependent: :destroy#userが消えるとmemberも消える
  has_many :comments,    dependent: :destroy #userが消えるとcommentも消える
  attachment :profile_image #refileが指定のカラムにアクセスするために必要

  validates :name,      presence: true #名前:空白禁止
  validates :nick_name, presence: true, uniqueness: true #ニックネーム:空白禁止、一意である

end
