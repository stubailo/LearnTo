class AddTagLineToToClassRoom < ActiveRecord::Migration
  def change
    add_column :class_rooms, :tag_line, :string

  end
end
