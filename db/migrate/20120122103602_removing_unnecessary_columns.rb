class RemovingUnnecessaryColumns < ActiveRecord::Migration
  def up
    remove_column :documents, :title
    remove_column :class_rooms, :creator_id
    add_column :class_rooms, :user_id, :integer
    add_index :class_rooms, :user_id
  end

  def down
    add_column :documents, :title, :string
    add_column :class_rooms, :creator_id, :integer
    remove_column :class_rooms, :user_id
  end
end
