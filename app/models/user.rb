class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #名前:空白禁止
  validates :name,presence: true
  #ニックネーム:空白禁止、一意である
  validates :nick_name, presence: true, uniqueness: true
  #userが消えるとgroup_userも消える
  has_many :group_users, dependent: :destroy
end
