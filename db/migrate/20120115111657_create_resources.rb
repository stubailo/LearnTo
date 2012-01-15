class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.has_attached_file :file
      t.string :name
      t.string :caption
      t.string :url
      t.string :type
      t.references :user
      t.references :class_room

      t.timestamps
    end
    add_index :resources, :class_room_id
    add_index :resources, :user_id
  end
end
