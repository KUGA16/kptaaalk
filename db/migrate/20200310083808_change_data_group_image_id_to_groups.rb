class ChangeDataGroupImageIdToGroups < ActiveRecord::Migration[5.2]
  def change
    change_column :groups, :group_image_id, :integer
  end
end
