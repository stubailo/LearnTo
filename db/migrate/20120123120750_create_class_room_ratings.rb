class CreateClassRoomRatings < ActiveRecord::Migration
  def change
    create_table :class_room_ratings do |t|
      t.references :user
      t.references :class_room
      t.integer :value

      t.timestamps
    end
    add_index :class_room_ratings, :user_id
    add_index :class_room_ratings, :class_room_id
  end
end
