class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.references :user
      t.references :class_room
      t.string :title
      t.text :content

      t.timestamps
    end
    add_index :announcements, :user_id
    add_index :announcements, :class_room_id
  end
end
