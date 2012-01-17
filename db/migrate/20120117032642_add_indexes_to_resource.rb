class AddIndexesToResource < ActiveRecord::Migration
  def change
    add_column :resources, :document_id, :integer
    
    add_index :resources, :document_id

  end
end
