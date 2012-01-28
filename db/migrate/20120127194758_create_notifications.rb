class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :action
      t.references :user
      t.boolean :read
      t.integer :item_id
      t.string :item_type
      t.timestamps
    end
    add_index :notifications, :user_id
  end
end
