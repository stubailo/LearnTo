class AddParentIdToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :parent_id, :integer

  end
end
