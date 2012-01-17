class RemoveRatingFromComments < ActiveRecord::Migration
  def up
    remove_column :comments, :rating
      end

  def down
    add_column :comments, :rating, :integer
  end
end
