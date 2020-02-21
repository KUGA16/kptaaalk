class User < ApplicationRecord
  #名前:空白禁止
  validates :name,presence: true
  #ニックネーム:空白禁止、一意である
  validates :nick_name, presence: true, uniqueness: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #登録時にメールアドレスを不要とする
  def email_required?
    false
  end

  def email_changed?
    false
  end

end
