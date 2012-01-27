class CreateResourceComments < ActiveRecord::Migration
  def change
    create_table :resource_comments do |t|
      t.references :resource
      t.references :user
      t.text :content

      t.timestamps
    end
    add_index :resource_comments, :resource_id
    add_index :resource_comments, :user_id
  end
end
