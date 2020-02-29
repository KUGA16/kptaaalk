class ChangeMembersToGroupUsers < ActiveRecord::Migration[5.2]
  def change
    rename_table :members, :group_users
  end
end
