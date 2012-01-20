class CreateHomeworkSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.integer :order
      t.string :title

      t.timestamps
    end
  end
end
