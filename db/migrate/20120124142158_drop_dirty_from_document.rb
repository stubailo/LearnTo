class DropDirtyFromDocument < ActiveRecord::Migration
  def up
    remove_column :documents, :dirty
  end

  def down
    add_column :documents, :dirty, :bool
  end
end
