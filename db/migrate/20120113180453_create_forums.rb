class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.references :class_room

      t.timestamps
    end
  end
end
