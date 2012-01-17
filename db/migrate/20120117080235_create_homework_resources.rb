class CreateHomeworkResources < ActiveRecord::Migration
  def change
    create_table :homework_resources do |t|
      t.references :homework
      t.references :resource

      t.timestamps
    end
    add_index :homework_resources, :homework_id
    add_index :homework_resources, :resource_id
  end
end
