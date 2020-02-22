class RemoveIndexNameFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_index :users, column: :name, unique: true
  end

  def up
    remove_index :users, :name
  end

  def down
    add_index :users, :name, unique: true
  end
end
