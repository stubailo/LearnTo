class CreateSubcomments < ActiveRecord::Migration
  def change
    create_table :subcomments do |t|
      t.references :user
      t.text :content

      t.timestamps
    end
    add_index :subcomments, :user_id
  end
end
