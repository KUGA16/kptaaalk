class ChangeDataGroupIdToComments < ActiveRecord::Migration[5.2]
  def change
    change_column :comments, :group_id, :integer
    change_column :comments, :user_id, :integer
  end
end
