class AddFileTypeToResource < ActiveRecord::Migration
  def change
    add_column :resources, :file_type, :string
  end
end
