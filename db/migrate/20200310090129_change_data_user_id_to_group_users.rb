class ChangeDataUserIdToGroupUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :group_users, :user_id, :integer
  end
end
