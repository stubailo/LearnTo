class AddCommentIdToSubcomment < ActiveRecord::Migration
  def change
    add_column :subcomments, :comment_id, :integer

  end
end
