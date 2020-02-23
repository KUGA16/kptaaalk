class CreateGroupUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :group_users do |t|
      t.string :user_id
      t.string :group_id
      t.boolean :is_confirmed

      t.timestamps
    end
  end
end
