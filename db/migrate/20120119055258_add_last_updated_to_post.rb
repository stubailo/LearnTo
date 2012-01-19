class AddLastUpdatedToPost < ActiveRecord::Migration
  def change
    add_column :posts, :last_updated, :datetime

  end
end
