class CreateResourcePages < ActiveRecord::Migration
  def change
    create_table :resource_pages do |t|
      t.string :section

      t.timestamps
    end
  end
end
