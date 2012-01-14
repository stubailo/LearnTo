class CreateUserPermissions < ActiveRecord::Migration
  def change
    create_table :user_permissions do |t|
      t.references :user
      t.references :class_room
      t.string :permission_type

      t.timestamps
    end
    add_index :user_permissions, :user_id
    add_index :user_permissions, :class_room_id
  end
end
