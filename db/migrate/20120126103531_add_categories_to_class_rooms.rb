class AddCategoriesToClassRooms < ActiveRecord::Migration
  def change
    add_column :class_rooms, :category, :string
  end
end
