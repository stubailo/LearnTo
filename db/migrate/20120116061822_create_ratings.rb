class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :user
      t.references :comment
      t.integer :value

      t.timestamps
    end
    add_index :ratings, :user_id
    add_index :ratings, :comment_id
  end
end
