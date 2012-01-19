class AddDirtyAndParsedToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :dirty, :boolean

    add_column :documents, :parsed_content, :text

  end
end
