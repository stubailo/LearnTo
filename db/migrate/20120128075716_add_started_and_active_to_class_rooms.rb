class AddStartedAndActiveToClassRooms < ActiveRecord::Migration
  def change
    add_column :class_rooms, :started, :boolean

    add_column :class_rooms, :active, :boolean

  end
end
