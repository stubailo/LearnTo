class AddClassRoomReferenceToResourcePages < ActiveRecord::Migration
  def change
    add_column :resource_pages, :class_room_id, :integer
    add_index :resource_pages, :class_room_id

  end
end
