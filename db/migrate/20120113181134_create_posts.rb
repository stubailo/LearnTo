class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user
      t.references :forum
      t.text :content
      t.string :title

      t.timestamps
    end
  end
end
