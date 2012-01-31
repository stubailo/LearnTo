class RemoveTagStuff < ActiveRecord::Migration
  def up
    drop_table :taggings
    drop_table :tags
  end

  def down
    create_table :tags 
    create_table :taggings 
  end
end
