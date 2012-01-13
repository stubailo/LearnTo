class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user
      t.references :post
      t.integer :rating
      t.text :content

      t.timestamps
    end
  end
end
