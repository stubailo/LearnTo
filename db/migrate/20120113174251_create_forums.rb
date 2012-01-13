class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.reference :class_room

      t.timestamps
    end
  end
end
