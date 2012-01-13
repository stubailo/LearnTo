class ChangeDateTimeToDateInClassRoom < ActiveRecord::Migration
  def up
    remove_column :class_rooms, :start_date
    remove_column :class_rooms, :end_date
    add_column :class_rooms, :start_date, :date
    add_column :class_rooms, :end_date, :date
  end

  def down
    remove_column :class_rooms, :start_date
    remove_column :class_rooms, :end_date
	add_column :class_rooms, :start_date, :timestamp
    add_column :class_rooms, :end_date, :timestamp
  end
end
