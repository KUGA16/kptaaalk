class ChangeDataUserIdToComments < ActiveRecord::Migration[5.2]
  def change
    change_column :comments, :user_id, :string
    change_column :comments, :group_id, :string
  end
end
