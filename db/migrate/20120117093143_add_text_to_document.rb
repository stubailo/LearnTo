class AddTextToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :content, :text

  end
end
