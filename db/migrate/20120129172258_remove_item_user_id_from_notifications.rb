class RemoveItemUserIdFromNotifications < ActiveRecord::Migration
  def up
    remove_column :notifications, :item_user_id
  end

  def down
    add_column :notifications, :item_user_id, :integer
  end
end
