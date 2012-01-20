class RestructureHierarchy < ActiveRecord::Migration
  def up
    drop_table :homeworks
    drop_table :homework_resources
    add_column :resources, :order, :integer
  end

  def down
  end
end
