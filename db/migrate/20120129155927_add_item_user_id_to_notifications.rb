class AddItemUserIdToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :item_user_id, :integer

  end
end
