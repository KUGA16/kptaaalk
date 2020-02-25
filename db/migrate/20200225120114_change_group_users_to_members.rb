class ChangeGroupUsersToMembers < ActiveRecord::Migration[5.2]
  def change
    rename_table :group_users, :members
  end
end
