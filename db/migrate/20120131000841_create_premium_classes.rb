class CreatePremiumClasses < ActiveRecord::Migration
  def change
    create_table :premium_classes do |t|
      t.references :class_room
      t.datetime :premium
      t.has_attached_file :image

      t.timestamps
    end
  end
end
