class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.references :resource
      t.string :title

      t.timestamps
    end
    add_index :documents, :resource_id
  end
end
