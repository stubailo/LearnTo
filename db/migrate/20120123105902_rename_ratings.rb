class RenameRatings < ActiveRecord::Migration
  def up
    rename_table :ratings, :post_ratings
  end

  def down
    rename_table :post_ratings, :ratings
  end
end
