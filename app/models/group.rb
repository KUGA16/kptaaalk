class Group < ApplicationRecord
  #groupが消えるとgroup_userも消える
  has_many :group_users, dependent: :destroy
end
