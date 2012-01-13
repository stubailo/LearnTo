class CreateClassroomsUsers < ActiveRecord::Migration
  def up
    create_table :classrooms_users, :id => false do |t|
      t.integer :class_room_id
      t.integer :user_id
    end
  end

  def down
	drop_table :classrooms_users
  end
end
