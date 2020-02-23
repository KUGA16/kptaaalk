class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #refileが指定のカラムにアクセスするために必要
  attachment :profile_image
  #名前:空白禁止
  validates :name,presence: true
  #ニックネーム:空白禁止、一意である
  validates :nick_name, presence: true, uniqueness: true

end
