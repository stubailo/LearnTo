class CreateHomeworks < ActiveRecord::Migration
  def change
    create_table :homeworks do |t|
      t.references :class_room
      t.integer :order
      t.references :homework_section

      t.timestamps
    end
    add_index :homeworks, :class_room_id
    add_index :homeworks, :homework_section_id
  end
end
