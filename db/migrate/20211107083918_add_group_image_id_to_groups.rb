class AddGroupImageIdToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :group_image_id, :text
  end
end
