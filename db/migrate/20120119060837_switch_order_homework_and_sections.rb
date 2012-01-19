class SwitchOrderHomeworkAndSections < ActiveRecord::Migration
  def up
    add_column :homework_sections, :class_room_id, :integer
    add_index :homework_sections, :class_room_id
    remove_column :homeworks, :class_room_id
  end

  def down
    remove_column :homework_sections, :class_room_id
    remove_index :homework_sections, :class_room_id
    add_column :homeworks, :class_room_id, :integer
    add_index :homeworks, :class_room_id
  end
end
