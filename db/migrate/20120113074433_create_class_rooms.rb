class CreateClassRooms < ActiveRecord::Migration
  def change
    create_table :class_rooms do |t|
      t.string :name
      t.integer :creator_id
      t.integer :occupancy
      t.decimal :price
      t.timestamp :start_date
      t.timestamp :end_date
      t.integer :description_id

      t.timestamps
    end
  end
end
