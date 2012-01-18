class AddSourceToResource < ActiveRecord::Migration
  def change
    add_column :resources, :source_call, :string
  end
end
