class UpdateRelationships < ActiveRecord::Migration
  def up
    add_column :resources, :section_id, :integer
    add_index :resources, :section_id
    remove_column :sections, :class_room_id
    add_column :sections, :resource_page_id, :integer
    add_index :sections, :resource_page_id
  end

  def down
    remove_column :sections, :resource_page_id
    remove_column :resources, :section_id
    add_column :sections, :class_room_id, :integer
    add_index :sections, :class_room_id
  end
end
