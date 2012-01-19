class AddSummaryToClassRooms < ActiveRecord::Migration
  def change
    add_column :class_rooms, :summary, :text

  end
end
