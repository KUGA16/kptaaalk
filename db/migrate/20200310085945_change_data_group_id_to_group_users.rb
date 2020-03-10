class ChangeDataGroupIdToGroupUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :group_users, :group_id, :integer
  end
end
